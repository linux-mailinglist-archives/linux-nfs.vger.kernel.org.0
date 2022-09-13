Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83E5B7C43
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIMUme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMUme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 16:42:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA038458
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32CC4B810BF
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 20:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC61CC433C1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663101746;
        bh=XuonAEU8vxC6jyjIWcpfRObxlg8bXm+Gr2lUbR25o2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TobhUUhz6B+ELxTnT+Lbl9X2vr7dXhJTAAYS63w6J6KXSk4CHWc/U54lrrrPg6Gdn
         N5UKvXODhCR63g7/unWyVUhIH/oK+z9HzDeKUy9cqH7tVAz06PSiXJo3DVQiveyPqY
         eDXLoVmULo0zCCi+N4Yv4+MsJY/xQQ9qwsLcQJidbHLycreauTSA03SFc6WuJoKWz0
         8oGCiLlBX+NvTOVPTHF9/8Q8JSYvKllUollCHPGTOpVhzXOmnFHwAfYm95zYgWNffE
         JDNhtIc2Q+4aoSPdF1Ge7xq2zDhxbkaMGjhkRAYAji7r0luvAh2hUWoBGvmobtD8m0
         oEpYy9kzGMroA==
Received: by mail-wm1-f47.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so14185179wma.2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:42:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo0dS3zHCTWuTQDhorjH2vSgdZbE2QVgUN5HZmTHEXp/K7qJUEV9
        +ylhp+ngJVuxZpaE/H1KsOOhJT8IjDdW91IKrhk=
X-Google-Smtp-Source: AA6agR6N1r+fnvvnBm5jHzKDuSNxgvCxmk43JHr3Sm2B9jrimNkykm5BglLyVA/qIUQRwBaU5eqQLKtbbcyKaCivDr8=
X-Received: by 2002:a05:600c:3516:b0:3a5:c28a:f01d with SMTP id
 h22-20020a05600c351600b003a5c28af01dmr764417wmq.165.1663101745438; Tue, 13
 Sep 2022 13:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220913180151.1928363-1-anna@kernel.org> <20220913180151.1928363-2-anna@kernel.org>
 <DE16B82B-67D9-49BA-B797-AC21AC8E7CE4@oracle.com>
In-Reply-To: <DE16B82B-67D9-49BA-B797-AC21AC8E7CE4@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 13 Sep 2022 16:42:09 -0400
X-Gmail-Original-Message-ID: <CAFX2JfmzD6JkrAiqMUCzJknnBwPiN5Ftd8WnysF6Qgeajcto6Q@mail.gmail.com>
Message-ID: <CAFX2JfmzD6JkrAiqMUCzJknnBwPiN5Ftd8WnysF6Qgeajcto6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 13, 2022 at 4:12 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > This was discussed with Chuck as part of this patch set. Returning
> > nfserr_resource was decided to not be the best error message here, and
> > he suggested changing to nfserr_serverfault instead.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfsd/nfs4xdr.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
>
> I've applied this one for nfsd for-next. Thanks!
>
> As I mentioned, 2/2 looks OK, and I'll apply it to my private
> tree for testing while we work out why it's a little slower.
>
>
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 1e9690a061ec..01dd73ed5720 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3994,7 +3994,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> >       }
> >       if (resp->xdr->buf->page_len && splice_ok) {
> >               WARN_ON_ONCE(1);
> > -             return nfserr_resource;
> > +             return nfserr_serverfault;
>
> Odd, I couldn't find a definition for nfserr_serverfault when
> I asked for this patch last week, but this one-liner seems to
> compile correctly. Oh well!

I found it in fs/nfsd/nfsd.h with `git grep`: #define
nfserr_serverfault      cpu_to_be32(NFSERR_SERVERFAULT)

Anna

>
>
> >       }
> >       xdr_commit_encode(xdr);
> >
> > --
> > 2.37.3
> >
>
> --
> Chuck Lever
>
>
>
