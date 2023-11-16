Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745587EE729
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKPTJK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 14:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKPTJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 14:09:09 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F8B8
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 11:09:06 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1f573a9ee2fso602564fac.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700161745; x=1700766545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8ft6GSijey+hqhIBboeivDD7EDa15Wfj8F8wiM2Bu0=;
        b=arKkNYnEVJdYEzcOfhOhgn2YtlwgZLWd6daYdopQ98swsop3CmjHeShHblPU6oWOR7
         FLcqx2gt5TffQL+QJoyo4lLQdBnXeH+0huZjDCD+GaeK1yR01a14hgP2uTJFzeswqo7N
         JavIIq2OV6V79wsG/0tAm+KhX7of6lAQ2S3uBoobhijezKzPtYpygj2VTcX67dtaQjm3
         svn+h6sumS72vOKvVHxb5Bf/HsK9S2C7dpeJGxolPmZxds/GtSelp6UCFcMeb2A2dWRp
         gkBtqE0vFtBZf0rEA7NGEQpTgqW60NmDi9nPiodoKTVsrBJYgBveH+Hh8mAmpXicOHOY
         KyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161745; x=1700766545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8ft6GSijey+hqhIBboeivDD7EDa15Wfj8F8wiM2Bu0=;
        b=ofc9I5phaqTPsIq+QcWjORc6ipwqBkpxmFVg7My+Gp3mPI//vCWFyKPzpVc8f5BQJC
         dRHC6MleyNW0g6YA16ylllQZgF48P+pxlypdroi7ZGv6P2Dos7CSeaCTlKz2UdzDKbjG
         BBtm25cFqcpEYCNR8M6S6J/FIe+J9Sxyxlv2+r5VVcYdQrSngwbJ6j4HYaZwsFXznUTv
         ohwZWu4tUcsb0/Ec0JuWGE4+CfRzd0cXsIfmxgiqJfeAKWxA2EEJi3toGsTT0GXsmurY
         Cs/DAiUHhULgTEcEBGdaUmcIgHuk43OYH3H4TuvOcTrtNo+k/COtJw6WfCRSNKn7TMRM
         bH5Q==
X-Gm-Message-State: AOJu0YzCXvc8jBVx2PT7BlcdTNu31ULqw+JH5lRs9Y1mlEfr+f6pNPq7
        s64NExOwNA1H19zfccHNW3gIx9+85D/FF/oG4X//zluE
X-Google-Smtp-Source: AGHT+IHSSY7/XdADbqLc+SS9junBVKpy9ZSFY6SBwm1nxbFUJBeNvTxcY93srwKohPvuyycgsURVzOY8Y9RF5hDQQ+0=
X-Received: by 2002:a05:6870:c90d:b0:1f0:8706:4c4a with SMTP id
 hj13-20020a056870c90d00b001f087064c4amr20993819oab.29.1700161745558; Thu, 16
 Nov 2023 11:09:05 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6PU1p6NzS3X6ohGFPjzxKXr3gXn70s-VV+HSzAAPbWyvQ@mail.gmail.com>
 <08A8C65F-5755-41DC-B29A-DE168B23C968@redhat.com>
In-Reply-To: <08A8C65F-5755-41DC-B29A-DE168B23C968@redhat.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Thu, 16 Nov 2023 20:08:54 +0100
Message-ID: <CANH4o6MF=TCRX=FA+OFeDXffVq5rKLcaNt7ZFPbt8_FxjWyOVg@mail.gmail.com>
Subject: Re: Does NFSv4 close-to-open consistency work with server "async"
 mount open?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 16, 2023 at 1:30=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 16 Nov 2023, at 2:11, Martin Wege wrote:
>
> > Hello,
> >
> > Does NFSv4 close-to-open consistency on the client work with server
> > "async" mount open?
>
> Yes, I believe it should, but I am looking at knfsd code and I think it
> won't.

What does that mean? nfsd server bug?

>
> > We see several build errors here with parallel GNU Makefile update,
> > where one process writes a file, exists, and the next process doesn't
> > see all data (linker ar: file too short).
> > But if you manually look at it the files are OK, and completely written=
.
> >
> > What is this? NFSv4 client bug, NFSv4 server bug, admin error (async
> > breaking close-to-open consistency?
>
> Hard to say, a wire capture would show.  My guess is that the server's
> "async" disables the write gather in nfsd_vfs_write().

What is the correct option in Linux /etc/exports to enforce NFSv4
standard conformance?

> > Also, is close-to-open consistency guaranteed between different NFSv4 c=
lients?
>
> Yes.

How does it work in a NFSv4 client implementation?

Thanks,
Martin
