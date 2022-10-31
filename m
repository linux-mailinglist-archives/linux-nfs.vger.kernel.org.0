Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72059613B62
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJaQdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiJaQdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 12:33:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E897412639
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 09:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86D7BB818EB
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 16:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF011C433C1;
        Mon, 31 Oct 2022 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667233994;
        bh=NCd7b862iSe5sSn2HM8o4Yv688qIBVT0HiGINLJaibw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d+h/YNYN/EiRa/+LM3Q13o80le3Tb30rTJ617KWRgVxSxIzJSnG1bz5UWRhZ9DnyL
         6WCbvakY9/pBXhdvTDlzeOZFd3dfesBkj+h0UfuoJVSjrNygmotm1ZtkebwOE8KgSc
         pdnNSp3haJ39Zn/KydIYTgkIUyaH6no1Unsg+/8ArsygUb3UYI7O+Yy3AfjMBMrlvH
         Kq9/E1JLmKqnYZZUbatc/iDfvRnGiKFZhPcxZ+ITyGDKKn1tJVPTRE19vEQ8KAtazT
         y9kB0909ly8jfr18ACydkhOuW/fSFlzYpAfKZ3o1gvL2UiZR1fDM6eKOmEfNkQfMJQ
         DcXBEmSFVBt0g==
Message-ID: <62ae1f0ba19068e035aae30a0ac022e55c7374b0.camel@kernel.org>
Subject: Re: [PATCH v7 05/14] NFSD: Trace stateids returned via DELEGRETURN
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 31 Oct 2022 12:33:12 -0400
In-Reply-To: <166696842358.106044.5702462087113424436.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
         <166696842358.106044.5702462087113424436.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 10:47 -0400, Chuck Lever wrote:
> Handing out a delegation stateid is recorded with the
> nfsd_deleg_read tracepoint, but there isn't a matching tracepoint
> for recording when the stateid is returned.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |    1 +
>  fs/nfsd/trace.h     |    1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c829b828b6fd..93cfae7cd391 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6901,6 +6901,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>  	if (status)
>  		goto put_stateid;
> =20
> +	trace_nfsd_deleg_return(stateid);
>  	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
>  	destroy_delegation(dp);
>  put_stateid:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index b065a4b1e0dc..477c2b035872 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -601,6 +601,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
> =20
>  DEFINE_STATEID_EVENT(open);
>  DEFINE_STATEID_EVENT(deleg_read);
> +DEFINE_STATEID_EVENT(deleg_return);
>  DEFINE_STATEID_EVENT(deleg_recall);
> =20
>  DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
