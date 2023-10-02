Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C77B542F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjJBNmJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjJBNmI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 09:42:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478879E
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 06:42:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8DDC433C8;
        Mon,  2 Oct 2023 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696254125;
        bh=S/gkxVysy/dtL+YeUcOUHZLwwrBBHV/UzD8sAcMoqBk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PReqvxEkUNGdky4bSnh0iPOtuqP9bWqqZ65/dEXpGzF2OCL5EhXixoNo8UpNavI8G
         4bQ3utdAD08anD+sjDA4KfcjsU4IKKdculcgH841VqRfN+bNbJXuTpx5PFDEYxTNw7
         dus+Xt4xVdewjhlDa53bWyeDlLtuBoQ5+zmkWtZMhNkVPpVwskjndIYKRxIm0ZMrbJ
         wimobSLavxkY0QTJy1q5pjadR0/a9to+9eQFAybTE1RH1UMA/kqp59x83vHGAu5A58
         XM4UIcTW6YPJMcHN+JqHPGTn/e7PagsfrdV9oSbahnlH+uwkjxeKD+gvzlQm+O+gpk
         SOtK2nomp+Uyw==
Message-ID: <9062843a7d70cf3e17d7eb9295783fcf7789c588.camel@kernel.org>
Subject: Re: [PATCH RFC 1/2] NFSD: Rewrite synopsis of
 nfsd_percpu_counters_init()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 02 Oct 2023 09:42:04 -0400
In-Reply-To: <169618110986.65416.1447879517809565525.stgit@manet.1015granger.net>
References: <169618103606.65416.14867860807492030083.stgit@manet.1015granger.net>
         <169618110986.65416.1447879517809565525.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-10-01 at 13:25 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> In function =E2=80=98export_stats_init=E2=80=99,
>     inlined from =E2=80=98svc_export_alloc=E2=80=99 at /home/cel/src/linu=
x/server-development/fs/nfsd/export.c:866:6:
> /home/cel/src/linux/server-development/fs/nfsd/export.c:337:16: warning: =
=E2=80=98nfsd_percpu_counters_init=E2=80=99 accessing 40 bytes in a region =
of size 0 [-Wstringop-overflow=3D]
>   337 |         return nfsd_percpu_counters_init(&stats->counter, EXP_STA=
TS_COUNTERS_NUM);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
> /home/cel/src/linux/server-development/fs/nfsd/export.c:337:16: note: ref=
erencing argument 1 of type =E2=80=98struct percpu_counter[0]=E2=80=99
> /home/cel/src/linux/server-development/fs/nfsd/stats.h: In function =E2=
=80=98svc_export_alloc=E2=80=99:
> /home/cel/src/linux/server-development/fs/nfsd/stats.h:40:5: note: in a c=
all to function =E2=80=98nfsd_percpu_counters_init=E2=80=99
>    40 | int nfsd_percpu_counters_init(struct percpu_counter counters[], i=
nt num);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/stats.c |    2 +-
>  fs/nfsd/stats.h |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index 63797635e1c3..12c299a05433 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -76,7 +76,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
> =20
>  DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
> =20
> -int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
> +int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
>  {
>  	int i, err =3D 0;
> =20
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index cf5524e7ca06..a3e9e2f47ec4 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -37,9 +37,9 @@ extern struct nfsd_stats	nfsdstats;
> =20
>  extern struct svc_stat		nfsd_svcstats;
> =20
> -int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)=
;
> -void nfsd_percpu_counters_reset(struct percpu_counter counters[], int nu=
m);
> -void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int =
num);
> +int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
> +void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num=
);
> +void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int n=
um);
>  int nfsd_stat_init(void);
>  void nfsd_stat_shutdown(void);
> =20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
