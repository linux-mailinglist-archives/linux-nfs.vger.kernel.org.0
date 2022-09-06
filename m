Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA095AF371
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiIFSSO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIFSSN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 14:18:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5B92F5A
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 11:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C38F6B819CB
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 18:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC1C433D6
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662488289;
        bh=Ql6SrXd6bfWAPD3voOz2AI4EfxBe1f2etHLu4qynFjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOmHoKjE6CjIw8hLbwf5vMDLsm4Cwv2prco9CG3nLYaJL7wvKVaRf66VW2V/WPd5b
         GF4ipNQ7dJvUhe9ZY+XyFqDmeV6buYyDYOKvozxlth9IcSdrP9ugQ5rgztMSZ5zHDD
         DT67q64oNNuu9cpsG/27AOabVhMRYkuPJa0oNI3XYyAXoqAzU3KacIOuLO5C/slcDV
         gYvgfqWTUNzFTjgCkBOZiYJPGcqq2BA22Ve0prMwpa8PqcJ/bDf2Eqy6HilzYANWFH
         yX9dQ31xHHY9tLVYECQqU+st/OGL6IcUpTqsAaYRiVUZGcPtwIQThCBCe297zyKsDL
         burkrzJWHAwDA==
Received: by mail-wr1-f44.google.com with SMTP id b16so16697810wru.7
        for <linux-nfs@vger.kernel.org>; Tue, 06 Sep 2022 11:18:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo3/jUnLXMFk+OSWQMDPvtDiQPJ88cdFysLp/K7HlFrERheqj5fS
        YB/GAqlSh+RufltZW0tM90DvGPp57J6RgUiDaLQ=
X-Google-Smtp-Source: AA6agR7p+lF3DuNy/wLliqtMV6B8/rhhOaij2KmyrkYzZonRDVj66ZDqE7SfAeyE/4MpqvGd0KSfzLw5ACQRosNYAfE=
X-Received: by 2002:a5d:5489:0:b0:228:94fa:9caa with SMTP id
 h9-20020a5d5489000000b0022894fa9caamr6199697wrv.227.1662488287925; Tue, 06
 Sep 2022 11:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220901183341.1543827-1-anna@kernel.org> <0125F316-1D9C-4A0E-B1B9-1919C9F26718@oracle.com>
In-Reply-To: <0125F316-1D9C-4A0E-B1B9-1919C9F26718@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 6 Sep 2022 14:17:51 -0400
X-Gmail-Original-Message-ID: <CAFX2JfnQ=KygdjYMk3uTy2T9N+We3BH_xiWT8eCG9Y7rrVOD3Q@mail.gmail.com>
Message-ID: <CAFX2JfnQ=KygdjYMk3uTy2T9N+We3BH_xiWT8eCG9Y7rrVOD3Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] NFSD: Simplify READ_PLUS
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

Hi Chuck,

On Sat, Sep 3, 2022 at 1:36 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 1, 2022, at 2:33 PM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > Chuck, I tried to add in sparse read support by adding this extra
> > change. Unfortunately it leads to a bunch of new failing xfstests. Do
> > you have any thoughts about what might be going on? Is the patch okay
> > without the splice support?
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index adbff7737c14..e21e6cfd1c6d 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4733,6 +4733,7 @@ static __be32
> > nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> >                           struct nfsd4_read *read)
> > {
> > +     bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
> >       unsigned long maxcount;
> >       struct xdr_stream *xdr = resp->xdr;
> >       struct file *file = read->rd_nf->nf_file;
> > @@ -4747,7 +4748,10 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> >       maxcount = min_t(unsigned long, read->rd_length,
> >                        (xdr->buf->buflen - xdr->buf->len));
> >
> > -     nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> > +     if (file->f_op->splice_read && splice_ok)
> > +             nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
> > +     else
> > +             nfserr = nfsd4_encode_readv(resp, read, file, maxcount)
> >       if (nfserr)
> >               return nfserr;
>
> I applied the above change to a test server, and was able to reproduce
> a bunch of new test failures when using NFSv4.2. I confirmed using nfsd
> tracepoints that splice read and READ_PLUS is being used.
>
> I then expanded the test. When using an XFS-based export, I reproduced
> the failures. But I was not able to reproduce these failures with
> exports based on tmpfs, btrfs, or ext4. Again, I confirmed using nfsd
> tracepoints that splice read was being used, and mountstats on my
> client showed READ_PLUS is being used.
>
> Then I tried testing the XFS-backed export with NFSv4.1, and found
> that most of the failures appeared again. Once again, I confirmed
> using nfsd tracepoints that splice read is being used during the tests.
>
> Can you confirm that you see test failures with NFSv4.1 and XFS but
> not with NFSv4.2 / READ_PLUS with btrfs, ext4, or tmpfs?

I can confirm that I'm seeing the same failures with NFS v4.1 and xfs,
but not with v4.2 and ext4. I didn't test btrfs or tmpfs, since the
ext4 test passed.

Should I re-add the splice change for v2 of this patch, in addition to
addressing the other comments you had?

Anna

>
>
> --
> Chuck Lever
>
>
>
