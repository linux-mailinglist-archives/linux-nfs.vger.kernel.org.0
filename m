Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1E665ECA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjAKPIS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbjAKPIQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 10:08:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD26382
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673449685; bh=GlZPZHjlA7ijS+Ua6u2SuoArSts7ClZoiAMYaIfV3Ek=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=nrK2KZAW+ycVKijoYRKOHn5KwNLYaPrSscBCljGsQQAkzXVSffqbVIiZX7tsIWUln
         juv78jxmi4Lpqq9Qe0WRgeDQWU6XryrTWv3UxS6J7AHHN7Pv3LxLksMVuCyfn/yV/O
         TLyb/cSYWtZWFzPpGV3yUvn42VhqhU5cWyIqPTwWLZeWzLZuRITdTFTObIiUWZM6Pe
         i5WjZuwVyBvp6oePqKDMwUBkT/X/vw5p2Y3eXTsjGgOYYzPWu725ebLp0x5qhckLSU
         uI54MJVi2s4W7Wn3J2wUiAiR1NfN40x2SXHKG+Ott1VAdMY2LiS9bszAHmchYGgz3S
         1M3gf3e5kSptg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1pVmmR3E0d-00JboR; Wed, 11
 Jan 2023 16:08:04 +0100
Message-ID: <67f3e5de50d1e21dba2ba7484f9df55c04bdabf5.camel@gmx.de>
Subject: Re: [PATCH 1/1] NFSD: register/unregister of nfsd-client shrinker
 at nfsd startup/shutdown time
From:   Mike Galbraith <efault@gmx.de>
To:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 11 Jan 2023 16:08:03 +0100
In-Reply-To: <23f1fda9f550a73182cafc140bb8dfb9af2ea874.camel@kernel.org>
References: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
         <23f1fda9f550a73182cafc140bb8dfb9af2ea874.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4X64IA3GP4e4L8ISJQYtPs6nU7OA/2X63mA++m3QutEkRm1DpH
 o/ptmZ8NdfqRV+4ETldtxV5NDRagABedmil/BYVUEveHK67h/FnvN4MvkKcsGicJ36CM2w3
 2bXLEESA373x0kc+f+XAmCJplhjKUVvvLLJebW2EkA2xDnG9nBSBrvG5L1QVIP7DjsMR2/E
 2jyuXQ9cXWhljYI+8pQxg==
UI-OutboundReport: notjunk:1;M01:P0:jGGbF2o/w/Q=;zqBomSJnreijc9DXpPS2z8bqdxm
 1YeEF90344W18pbxykJJDDqB/qIwtTA7K9Y+nebielEpLgF4EmOCj6EHBr4VvZZ5irh0xhXlM
 zfTgEMHdgnrs1GZIxKBsJwH4Vwbgwh2UuN4jLfHJXF94xCzO/4oUfQ5sxzeeC0w2P6FPY5J70
 p4pg9NjwbKaLCvtxNlXhrxOwz7yO9siDlZFoA1cyXwbNpdf8vTQ8GNVl52MFGcL1dEb5/E9za
 mdssbMmGL4wxc03IvdcEnsAI3cIaTvHDyIBWbjnpb4rach5MZH81k/sMz1TGUyR1qIUwdjCAn
 CNQsSgt4wJwDGNHcU1sx/I62fLIAruWYHM0fdxgdoOgyNgkeFD+b0mtfVSnKvpGpnmbfP/HpJ
 tiJiNR5VOJGxxt/cDAeIOYq6ItrWZK3s5HRWVRqjIHFcPMun8Bl2F6sFSf2enpCT3JFCcJ9vD
 cwHl8GU0X1REpQR/ru8HAghUHNFVGn9eCx4dtonw1QtDwyB/A1Ur6YRYWVxvEGu26WYdmg8U0
 wxg29IWOIsxttGNMhKQsdJNqnsdXd3cKolqwwOPG+bFv5RHvtynUUMla56rMR2y4FtYV3P2kY
 JffUzJf0sHLjZD1ku9MjMp00om8VOjE3+39XsZzifAnhzYgGBby3sp+1bLnlbOtKwMrdnqCqN
 SpUxn3USGw8n9Lvp9fK0BooBkniF1PGsC6oTfcXQqZIFsZJ8SCj92d1mapDeWveop6CRdkWrq
 7vquGepjPSAJbNMv2/f6EThVegLA/QXaT12K/xnSU29IKCBI/O27RXKqhsfzQvDLQtgbJBkiR
 fPE9h5pS0xjyZB7AVb1gMtO0EkV12O1/Vw8tFXmTkALt1s5PfYcgQ3mJJpcFply0te7CKLF+6
 VWick8sMwzXTGr7RHIuxAmVDov2crLUW2Dfzg1lcVocmH7rqvwOj7x4HNToJH1jLfyJJ+Bnqe
 DG/BDhjWIRUm4qhFiDVaa5NQCAI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 09:34 -0500, Jeff Layton wrote:
>
> I suspect that this patch is probably enough to fix the problem that
> Mike is hitting. Perhaps we should mark this for stable after revising
> the changelog?
>
> Mike, would you be able to test this patch and see whether it fixes the
> shrinker oopses you've been hitting? It's also commit a77ce15ca9cb10 in
> Chuck's git tree.

Yup, all better.

	-Mike
