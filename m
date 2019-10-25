Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6BE4F8E
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfJYOvz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Oct 2019 10:51:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728985AbfJYOvz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Oct 2019 10:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572015113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mp33VwO5RL+wjnZQlilpTwWCWWg3fv0Lg34B7Bg29OU=;
        b=jFoIPwl0PWPvx1vGC0mm/fj0SBJ1cAwH4hrgaHlyAIysvnfiebNOibgtTAtrBZzYNMdCi2
        94nrB4k/7cRifCXEmj5N28maBCKJUT/Hbfzj7wDZRXR/Dbe+btIfGMEdpI8Sh2m5JDp8tj
        KbbJgLKUZNMYVvvXIFjw1Jn6QfyDulM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-PO00tv8iP-6IGKPdz7v1vA-1; Fri, 25 Oct 2019 10:51:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6A708017D9;
        Fri, 25 Oct 2019 14:51:49 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-126-116.rdu2.redhat.com [10.10.126.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59D2B19C7F;
        Fri, 25 Oct 2019 14:51:49 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id A545F120039; Fri, 25 Oct 2019 10:51:47 -0400 (EDT)
Date:   Fri, 25 Oct 2019 10:51:47 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Fix races between nfsd4_cb_release() and
 nfsd4_shutdown_callback()
Message-ID: <20191025145147.GA16053@pick.fieldses.org>
References: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
In-Reply-To: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PO00tv8iP-6IGKPdz7v1vA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 23, 2019 at 05:43:18PM -0400, Trond Myklebust wrote:
> When we're destroying the client lease, and we call
> nfsd4_shutdown_callback(), we must ensure that we do not return
> before all outstanding callbacks have terminated and have
> released their payloads.

This is great, thanks!  We've seen what I'm fairly sure is the same bug
from Red Hat users.  I think my blind spot was an assumption that
rpc tasks wouldn't outlive rpc_shutdown_client().

However, it's causing xfstests runs to hang, and I haven't worked out
why yet.

I'll spend some time on it this afternoon and let you know what I figure
out.

--b.

> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> v2 - Fix a leak of clp->cl_cb_inflight when running null probes
>=20
>  fs/nfsd/nfs4callback.c | 97 +++++++++++++++++++++++++++++++++---------
>  fs/nfsd/state.h        |  1 +
>  2 files changed, 79 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 524111420b48..a3c9517bcc64 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -826,6 +826,31 @@ static int max_cb_time(struct net *net)
>  =09return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
>  }
> =20
> +static struct workqueue_struct *callback_wq;
> +
> +static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
> +{
> +=09return queue_work(callback_wq, &cb->cb_work);
> +}
> +
> +static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
> +{
> +=09atomic_inc(&clp->cl_cb_inflight);
> +}
> +
> +static void nfsd41_cb_inflight_end(struct nfs4_client *clp)
> +{
> +
> +=09if (atomic_dec_and_test(&clp->cl_cb_inflight))
> +=09=09wake_up_var(&clp->cl_cb_inflight);
> +}
> +
> +static void nfsd41_cb_inflight_wait_complete(struct nfs4_client *clp)
> +{
> +=09wait_var_event(&clp->cl_cb_inflight,
> +=09=09=09!atomic_read(&clp->cl_cb_inflight));
> +}
> +
>  static const struct cred *get_backchannel_cred(struct nfs4_client *clp, =
struct rpc_clnt *client, struct nfsd4_session *ses)
>  {
>  =09if (clp->cl_minorversion =3D=3D 0) {
> @@ -937,14 +962,21 @@ static void nfsd4_cb_probe_done(struct rpc_task *ta=
sk, void *calldata)
>  =09=09clp->cl_cb_state =3D NFSD4_CB_UP;
>  }
> =20
> +static void nfsd4_cb_probe_release(void *calldata)
> +{
> +=09struct nfs4_client *clp =3D container_of(calldata, struct nfs4_client=
, cl_cb_null);
> +
> +=09nfsd41_cb_inflight_end(clp);
> +
> +}
> +
>  static const struct rpc_call_ops nfsd4_cb_probe_ops =3D {
>  =09/* XXX: release method to ensure we set the cb channel down if
>  =09 * necessary on early failure? */
>  =09.rpc_call_done =3D nfsd4_cb_probe_done,
> +=09.rpc_release =3D nfsd4_cb_probe_release,
>  };
> =20
> -static struct workqueue_struct *callback_wq;
> -
>  /*
>   * Poke the callback thread to process any updates to the callback
>   * parameters, and send a null probe.
> @@ -975,9 +1007,12 @@ void nfsd4_change_callback(struct nfs4_client *clp,=
 struct nfs4_cb_conn *conn)
>   * If the slot is available, then mark it busy.  Otherwise, set the
>   * thread for sleeping on the callback RPC wait queue.
>   */
> -static bool nfsd41_cb_get_slot(struct nfs4_client *clp, struct rpc_task =
*task)
> +static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_tas=
k *task)
>  {
> -=09if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> +=09struct nfs4_client *clp =3D cb->cb_clp;
> +
> +=09if (!cb->cb_holds_slot &&
> +=09    test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
>  =09=09rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
>  =09=09/* Race breaker */
>  =09=09if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> @@ -985,10 +1020,32 @@ static bool nfsd41_cb_get_slot(struct nfs4_client =
*clp, struct rpc_task *task)
>  =09=09=09return false;
>  =09=09}
>  =09=09rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> +=09=09cb->cb_holds_slot =3D true;
>  =09}
>  =09return true;
>  }
> =20
> +static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> +{
> +=09struct nfs4_client *clp =3D cb->cb_clp;
> +
> +=09if (cb->cb_holds_slot) {
> +=09=09cb->cb_holds_slot =3D false;
> +=09=09clear_bit(0, &clp->cl_cb_slot_busy);
> +=09=09rpc_wake_up_next(&clp->cl_cb_waitq);
> +=09}
> +}
> +
> +static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
> +{
> +=09struct nfs4_client *clp =3D cb->cb_clp;
> +
> +=09nfsd41_cb_release_slot(cb);
> +=09if (cb->cb_ops && cb->cb_ops->release)
> +=09=09cb->cb_ops->release(cb);
> +=09nfsd41_cb_inflight_end(clp);
> +}
> +
>  /*
>   * TODO: cb_sequence should support referring call lists, cachethis, mul=
tiple
>   * slots, and mark callback channel down on communication errors.
> @@ -1005,11 +1062,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task=
, void *calldata)
>  =09 */
>  =09cb->cb_seq_status =3D 1;
>  =09cb->cb_status =3D 0;
> -=09if (minorversion) {
> -=09=09if (!cb->cb_holds_slot && !nfsd41_cb_get_slot(clp, task))
> -=09=09=09return;
> -=09=09cb->cb_holds_slot =3D true;
> -=09}
> +=09if (minorversion && !nfsd41_cb_get_slot(cb, task))
> +=09=09return;
>  =09rpc_call_start(task);
>  }
> =20
> @@ -1076,9 +1130,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task =
*task, struct nfsd4_callback
>  =09=09=09cb->cb_seq_status);
>  =09}
> =20
> -=09cb->cb_holds_slot =3D false;
> -=09clear_bit(0, &clp->cl_cb_slot_busy);
> -=09rpc_wake_up_next(&clp->cl_cb_waitq);
> +=09nfsd41_cb_release_slot(cb);
>  =09dprintk("%s: freed slot, new seqid=3D%d\n", __func__,
>  =09=09clp->cl_cb_session->se_cb_seq_nr);
> =20
> @@ -1091,8 +1143,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task=
 *task, struct nfsd4_callback
>  =09=09ret =3D false;
>  =09goto out;
>  need_restart:
> -=09task->tk_status =3D 0;
> -=09cb->cb_need_restart =3D true;
> +=09if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> +=09=09task->tk_status =3D 0;
> +=09=09cb->cb_need_restart =3D true;
> +=09}
>  =09return false;
>  }
> =20
> @@ -1134,9 +1188,9 @@ static void nfsd4_cb_release(void *calldata)
>  =09struct nfsd4_callback *cb =3D calldata;
> =20
>  =09if (cb->cb_need_restart)
> -=09=09nfsd4_run_cb(cb);
> +=09=09nfsd4_queue_cb(cb);
>  =09else
> -=09=09cb->cb_ops->release(cb);
> +=09=09nfsd41_destroy_cb(cb);
> =20
>  }
> =20
> @@ -1170,6 +1224,7 @@ void nfsd4_shutdown_callback(struct nfs4_client *cl=
p)
>  =09 */
>  =09nfsd4_run_cb(&clp->cl_cb_null);
>  =09flush_workqueue(callback_wq);
> +=09nfsd41_cb_inflight_wait_complete(clp);
>  }
> =20
>  /* requires cl_lock: */
> @@ -1255,8 +1310,7 @@ nfsd4_run_cb_work(struct work_struct *work)
>  =09clnt =3D clp->cl_cb_client;
>  =09if (!clnt) {
>  =09=09/* Callback channel broken, or client killed; give up: */
> -=09=09if (cb->cb_ops && cb->cb_ops->release)
> -=09=09=09cb->cb_ops->release(cb);
> +=09=09nfsd41_destroy_cb(cb);
>  =09=09return;
>  =09}
> =20
> @@ -1265,6 +1319,7 @@ nfsd4_run_cb_work(struct work_struct *work)
>  =09 */
>  =09if (!cb->cb_ops && clp->cl_minorversion) {
>  =09=09clp->cl_cb_state =3D NFSD4_CB_UP;
> +=09=09nfsd41_destroy_cb(cb);
>  =09=09return;
>  =09}
> =20
> @@ -1290,5 +1345,9 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struc=
t nfs4_client *clp,
> =20
>  void nfsd4_run_cb(struct nfsd4_callback *cb)
>  {
> -=09queue_work(callback_wq, &cb->cb_work);
> +=09struct nfs4_client *clp =3D cb->cb_clp;
> +
> +=09nfsd41_cb_inflight_begin(clp);
> +=09if (!nfsd4_queue_cb(cb))
> +=09=09nfsd41_cb_inflight_end(clp);
>  }
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 46f56afb6cb8..d61b83b9654c 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -367,6 +367,7 @@ struct nfs4_client {
>  =09struct net=09=09*net;
>  =09struct list_head=09async_copies;=09/* list of async copies */
>  =09spinlock_t=09=09async_lock;=09/* lock for async copies */
> +=09atomic_t=09=09cl_cb_inflight;=09/* Outstanding callbacks */
>  };
> =20
>  /* struct nfs4_client_reset
> --=20
> 2.21.0
>=20

