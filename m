Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3168A78D122
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 02:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbjH3Aal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 20:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjH3Aae (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 20:30:34 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D497FCCA
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 17:30:30 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a28de15c8aso3427538fac.2
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693355430; x=1693960230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbYpl6ns/62nSAZ+2ZZEQQ6s0NiSU98Apfll0ZDa+tQ=;
        b=d6uoQzbtbxRqwNGkvo0UAkryvtDGTXCKMSX7BdU6k5PCDF9tjbwcpHYWwH5bCJ00Z7
         SnI3zZwjogcAgkOptX5ZfuiwfwBOCWJyRoE1JEpvHdF9AmFO49smWVp0qnFCmi69bl1Z
         WgtE3RXGGCFJf0tHJ7aUhDgeX6yLWB8EhRwyccajIdlCVDXORxIntD0I0uS5wfpi6Icp
         ePpWvms37wd8wS7YYk0PhOgf3vHEJp0ReOUcTFYZfBwi6RfA4yjMkAxkHwhZJJ76asqB
         foJ2qaTpG4+wiwuh0LcpPwHsk1+LhvJxH2pWbKKqXlwqicIj1lxUIMkoi3bXLz9U7xeG
         CvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355430; x=1693960230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbYpl6ns/62nSAZ+2ZZEQQ6s0NiSU98Apfll0ZDa+tQ=;
        b=ax7wzzggbLETbrRKHuw+QlvQPbydLme5Jym60EoNLrp44GudOr5l7e/Sqs12pmfMuy
         ssb+6YLRZDqrk/Ly0JQT1O1W11hUtwm/Ursz/7lslS6z8Mx8425+YLxrf7Gaqq7jera+
         6LIqJVh4/8Oqxwgu5ts6OX4zuL2Z23zRunzP+QMH01IVvO4Y3CUd1bN15h8SvMO/lHgo
         uDEcFlY2zTDOUSxSjylmA6zCqR6a2ILYfFCwSG0uhS63NK4RcF6HZExzi9d6FbeOnEiJ
         aaY21MD5m7T97hOmWZYStE6RXKnc8WZ/CGb/yXXd4uWooVhQorENmcQ3NRY9tiStwR1i
         wY+w==
X-Gm-Message-State: AOJu0YwkE1n2ohcqGQxGRcr1cSeqcIFuvTCWH9m9WlWDNXV5Q0OmDYG3
        aIu8eGrIx5CDL7w/PJTCu8XSIh7FHzFJWbv+WHIA4204rw==
X-Google-Smtp-Source: AGHT+IFOmREJ2y5u5PefKzemtR5W0nbtmN9XT6Eq3dMhmmY7HrkJOlzQ5YfZz20tuVmhmS2D7UAIKtX5rZugSqFFSrg=
X-Received: by 2002:a05:6870:32d1:b0:1d0:bd4f:d998 with SMTP id
 r17-20020a05687032d100b001d0bd4fd998mr929287oac.55.1693355430144; Tue, 29 Aug
 2023 17:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5tNy7Q63k+9+f9zrctZrm-NzCbYn8OjYSirQ8g+g7yLaK9jQ@mail.gmail.com>
 <CAMa=BDoUS8ny1X+GjDR1hDGg1h9zjtSzet1Rtu8=GwJfsu-kJQ@mail.gmail.com>
In-Reply-To: <CAMa=BDoUS8ny1X+GjDR1hDGg1h9zjtSzet1Rtu8=GwJfsu-kJQ@mail.gmail.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Tue, 29 Aug 2023 17:30:20 -0700
Message-ID: <CAM5tNy6ecGrKToFneMi14MnWP5BhS39kJJpxLCmk4AWgeU6+tg@mail.gmail.com>
Subject: Re: [nfsv4] pNFS/Flexfiles testing at Oct. Bakeathon
To:     Tom Haynes <loghyr@gmail.com>
Cc:     NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 28, 2023 at 7:03=E2=80=AFPM Tom Haynes <loghyr@gmail.com> wrote=
:
>
> Hi Rick,
>
> I'll have server implementations of all of them.
>
> Wait, maybe not the WCC.
I was thinking that WCC was the interesting one. The FreeBSD pNFS server us=
es
v4.2 DSs, so it would be client side only for FreeBSD. (It's too bad
that NFSv4 DSs
cannot do this, but I cannot think how they could unless a new
Write-with-WCC operation
was added to NFSv4.2.)

Will you know soon if you'd have a server for the Bakeathon?

>
> My clients will also have the implementations, normally they only talk to=
 my server, but I can bring a standalone client for testing.
The FreeBSD pNFS server never issues delegations, so delstid wouldn't
really apply.
(The non-pNFS server does do delegations. Is delstid generic enough
that a non-pNFS
server should do it?)

The only other one I recall is the LayoutReturn with an error after the MDS
reboot. Not something we'd want to test at the Bakeathon, I'd guess?

Thanks for the info, rick

>
> Tom
>
> On Mon, Aug 28, 2023, 18:40 Rick Macklem <rick.macklem@gmail.com> wrote:
>>
>> Hi,
>>
>> Tom has a few IETF drafts describing changes that I believe are
>> aimed at improving pNFS Flex Files layout.
>>
>> I was wondering if implementations of any of these will be
>> available at the Oct. Bakeathon?
>>
>> I have not implemented any of them as yet, but I might have
>> time to do an experimental implementation of some of them
>> for the Oct. Bakeathon, if there will be implementations to test
>> against.
>>
>> Thanks for any info, rick
>>
>> _______________________________________________
>> nfsv4 mailing list
>> nfsv4@ietf.org
>> https://www.ietf.org/mailman/listinfo/nfsv4
