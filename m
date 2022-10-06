Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115815F6B34
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJFQGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJFQGc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:06:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0986B8D6
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C2A5B8060E
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 16:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB676C433C1;
        Thu,  6 Oct 2022 16:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665072385;
        bh=g8N/n9s5jg0AtvZF85vAHxzNlvuAL8iZle3wcNiGIIE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=pj0Mk2WUZ+PpRfIph2gBEXxSMFqsm/fVX87c4HArmlmGSC6o9KfTYxk64STnDIuj4
         MDDAQYcL0tNK+vv1XIKP+uYg8/BcAt2YZiEGYE98V/1r64JYJikOeZWY4uwSHTwlls
         hWCvzVmVc3g3k6OvpqgUJWG/eMIkiL5UI2mChRXm3qzgpLWv/WG/Q8Lzxrk0KzYrQW
         2hoe8UVCWdFI3w3VEuF5SwePRs+5uX8GBayKyRs7sTOg3AOnkNxCiyBmNzdm5jIHv/
         +5fAxE+q9JmXvS3JLe9ThdTU1+AgQJHaasPRHc+Cv+AZ54xtbI7ix/QvSy3EnQjeRd
         N8E6FoeeVQeAQ==
Message-ID: <29bbe1baca5c86908d62c3ea83f7c3eb1ab22d9c.camel@kernel.org>
Subject: Re: [PATCH RFC 9/9] NFSD: Trace delegation revocations
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 06 Oct 2022 12:06:23 -0400
In-Reply-To: <166498179300.1527.10706291618523188126.stgit@manet.1015granger.net>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
         <166498179300.1527.10706291618523188126.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-10-05 at 10:56 -0400, Chuck Lever wrote:
> Revocation is an exceptional event. Generate a trace record when it
> occurs so that other activity can be triggered.
>=20
> Example:
>=20
> nfsd-1104  [005]  1912.002544: nfsd_stid_revoke:        client 633c9343:4=
e82788d stateid 00000003:00000001 ref=3D2 type=3DDELEG
>=20
> Trace infrastructure is provided for subsequent additional tracing
> related to nfs4_stid activity.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |    2 ++
>  fs/nfsd/trace.h     |   55 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 57 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 06499b9481a6..349302afa7eb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1404,6 +1404,8 @@ static void revoke_delegation(struct nfs4_delegatio=
n *dp)
> =20
>  	WARN_ON(!list_empty(&dp->dl_recall_lru));
> =20
> +	trace_nfsd_stid_revoke(&dp->dl_stid);
> +
>  	if (clp->cl_minorversion) {
>  		dp->dl_stid.sc_type =3D NFS4_REVOKED_DELEG_STID;
>  		refcount_inc(&dp->dl_stid.sc_count);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4921144880d3..23fb39c957af 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -561,6 +561,61 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
>  DEFINE_STATESEQID_EVENT(preprocess);
>  DEFINE_STATESEQID_EVENT(open_confirm);
> =20
> +TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
> +TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
> +TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
> +TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> +TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> +TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> +TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> +
> +#define show_stid_type(x)						\
> +	__print_flags(x, "|",						\
> +		{ NFS4_OPEN_STID,		"OPEN" },		\
> +		{ NFS4_LOCK_STID,		"LOCK" },		\
> +		{ NFS4_DELEG_STID,		"DELEG" },		\
> +		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> +		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> +		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
> +		{ NFS4_LAYOUT_STID,		"LAYOUT" })
> +
> +DECLARE_EVENT_CLASS(nfsd_stid_class,
> +	TP_PROTO(
> +		const struct nfs4_stid *stid
> +	),
> +	TP_ARGS(stid),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, sc_type)
> +		__field(int, sc_count)
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__field(u32, si_id)
> +		__field(u32, si_generation)
> +	),
> +	TP_fast_assign(
> +		const stateid_t *stp =3D &stid->sc_stateid;
> +
> +		__entry->sc_type =3D stid->sc_type;
> +		__entry->sc_count =3D refcount_read(&stid->sc_count);
> +		__entry->cl_boot =3D stp->si_opaque.so_clid.cl_boot;
> +		__entry->cl_id =3D stp->si_opaque.so_clid.cl_id;
> +		__entry->si_id =3D stp->si_opaque.so_id;
> +		__entry->si_generation =3D stp->si_generation;
> +	),
> +	TP_printk("client %08x:%08x stateid %08x:%08x ref=3D%d type=3D%s",
> +		__entry->cl_boot, __entry->cl_id,
> +		__entry->si_id, __entry->si_generation,
> +		__entry->sc_count, show_stid_type(__entry->sc_type)
> +	)
> +);
> +
> +#define DEFINE_STID_EVENT(name)					\
> +DEFINE_EVENT(nfsd_stid_class, nfsd_stid_##name,			\
> +	TP_PROTO(const struct nfs4_stid *stid),			\
> +	TP_ARGS(stid))
> +
> +DEFINE_STID_EVENT(revoke);
> +
>  DECLARE_EVENT_CLASS(nfsd_clientid_class,
>  	TP_PROTO(const clientid_t *clid),
>  	TP_ARGS(clid),
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
