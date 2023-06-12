Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61D72CD4E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFLR4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLR4f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 13:56:35 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 10:56:33 PDT
Received: from mxout6.mail.janestreet.com (mxout6.mail.janestreet.com [64.215.233.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2143DB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 10:56:33 -0700 (PDT)
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.96)
        id 1q8lga-0069NN-1j
        for linux-nfs@vger.kernel.org;
        Mon, 12 Jun 2023 13:50:37 -0400
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f51145635fso523189e87.1
         for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1686592235; x=1689184235;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=8wY7BcC4HqsJhHBGPkPZ+ibhRSXZlvpBmV05Ih9LSHk=;
         b=pTvx82/eLfxZV2Kwecu90rOngxaXWrICaEEOJSOU93cYYcH9yTj6DQSlAAC5PSKyrX
          cbT+k4mNrRI4ScXLYC/oFM8zhoVP4iwRQICBTv4Js7gexLtnIvCP/NlEAiQTsblt8dpj
          TNkfr9QuRmPMFJ5YpfM2S1HTRmZVvrJBHbGRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20221208; t=1686592235; x=1689184235;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
          :subject:date:message-id:reply-to;
         bh=8wY7BcC4HqsJhHBGPkPZ+ibhRSXZlvpBmV05Ih9LSHk=;
         b=iyT4mFgoz0OINKAFFOpPL3HvM2xYCDvN2f2zQyxLkGPAhzmvU73+1KiFd30C8JAGMa
          6e4We1Y1ieonUYK9CQhwzxv4PWNyt5bV61z4433UpD+c/Ms0nxO4UirIaKy85pfKhvKi
          xnu1QDmFZEcBeAsx1JglEBRpBR2O94IN7ocdhWyPFbTlloqN0VaIGoRgF/d/lXE3s0zj
          QtDN38rQj7NitWK9gxOm+4Aot1yaAhOG92Y433rzl4fnU8i4kEB5F/zrIH790FM5X9aG
          JA/WwrqhLkFrfLye0INPkSDlioD81eMqKs9Ti8LBndJL7rm521SZ5LVEa3H5n49XgPql
          UbOA==
X-Gm-Message-State: AC+VfDx59dvIDtqJ4ZpBOQK4TbmF5g7V11KpSFFhxBKgFa2IG3Dp89EX
        DVWfGN7bi0ISVbCpnWtWucy/vTcubysteqnGPkL4woAXHK1UPuh+nqliBC+iZrvuru0AVIFuca7
        +Kxiv0yzLMC8ViPIkuMrui830RK2mVufSInmbpC2g5bY1Ug==
X-Received: by 2002:a05:6512:4db:b0:4f6:2625:547c with SMTP id w27-20020a05651204db00b004f62625547cmr3942376lfq.5.1686592235306;
         Mon, 12 Jun 2023 10:50:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hgwD8sSE7ADZg7ydRoC5HWEaKIIlMg4FJPQgXZNRMQl6y5Z1yDO8oUp4UcpMQX6JE+h0zFoGAgqPsxYRBKvk=
X-Received: by 2002:a05:6512:4db:b0:4f6:2625:547c with SMTP id
  w27-20020a05651204db00b004f62625547cmr3942364lfq.5.1686592234841; Mon, 12 Jun
  2023 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
  <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
  <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
  <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org> <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
In-Reply-To: <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
From:   Chris Perl <cperl@janestreet.com>
Date:   Mon, 12 Jun 2023 13:49:58 -0400
Message-ID: <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
Subject: Re: Too many ENOSPC errors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 12, 2023 at 1:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2023-06-12 at 11:58 -0400, Jeff Layton wrote:
>
> >
> > Got it: I think I see what's happening. filemap_sample_wb_err just call=
s
> > errseq_sample, which does this:
> >
> > errseq_t errseq_sample(errseq_t *eseq)
> > {
> >         errseq_t old =3D READ_ONCE(*eseq);
> >
> >         /* If nobody has seen this error yet, then we can be the first.=
 */
> >         if (!(old & ERRSEQ_SEEN))
> >                 old =3D 0;
> >         return old;
> > }
> >
> > Because no one has seen that error yet (ERRSEQ_SEEN is clear), the writ=
e
> > ends up being the first to see it and it gets back a 0, even though the
> > error happened before the sample.
> >
> > The above behavior is what we want for the sample that we do at open()
> > time, but not what's needed for this use-case. We need a new helper tha=
t
> > samples the value regardless of whether it has already been seen:
> >
> > errseq_t errseq_peek(errseq_t *eseq)
> > {
> >       return READ_ONCE(*eseq);
> > }
> >
> > ...but we'll also need to fix up errseq_check to handle differences
> > between the SEEN bit.
> >
> > I'll see if I can spin up a patch for that. Stay tuned.
>
> This may not be fixable with the way that NFS is trying to use errseq_t.
>
> The fundamental problem is that we need to mark the errseq_t in the
> mapping as SEEN when we sample it, to ensure that a later error is
> recorded and not ignored.
>
> But...if the error hasn't been reported yet and we mark it SEEN here,
> and then a later error doesn't occur, then a later open won't have its
> errseq_t set to 0, and that unseen error could be lost.
>
> It's a bit of a pity: as originally envisioned, the errseq_t mechanism
> would provide for this sort of use case, but we added this patch not
> long after the original code went in, and it changed those semantics:
>
>     b4678df184b3 errseq: Always report a writeback error once
>
> I don't see a good way to do this using the current errseq_t mechanism,
> given these competing needs. I'll keep thinking about it though. Maybe
> we could add some sort of store and forward mechanism for fsync on NFS?
> That could get rather complex though.

Can/should it be marked SEEN when the initial close(2) from tee(1)
reports the error?

Part of the reason I had originally asked about `nfs_file_flush' (i.e.
what close(2) calls) using `file_check_and_advance_wb_err' instead of
`filemap_check_wb_err' was because I was drawn to comparing
`nfs_file_flush' against `nfs_file_fsync' as it seems like in the 3.10
based EL7 kernels, the former used to delegate to the latter (by way
of `vfs_fsync') and so they had consistent behavior, whereas now they
do not.
