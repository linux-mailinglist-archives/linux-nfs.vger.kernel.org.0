Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25A87E365
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfHATjS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 15:39:18 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:44094 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388672AbfHATjS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Aug 2019 15:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564688356; bh=0KGj3MsZBf1DQldv0NGaLOQBDYCbRcA418Q2pYmEHFQ=; h=To:Cc:From:Subject:Date:From:Subject; b=hQNvd79bZrIsz9tRNEATEVH0JtigmCR7bV+gAT5F4cVyr8gXISe7XndoaBVm9qtKnDF54ajWoWqs+DHkRWQh7ol3LcnaD0lNGK+5b9Eh0vs2gkTZ1z+dvH40CYyomBKEZz0mHLptBSOOwXJcnO4t7+uhJpv3UzVo4lh+6qeAHUsGO2QWcIOWIGGllh9zFlbpEeUNyLzTLVEtTzyOUbsp6j5J0k3/HaavMww4gmVXY+zS1mGuJcnEkkfqVyhmKuMeWpg2gWJ5V4ILS8kkEVZ+BWM/lick4zMjILF90M6R4RRUkdIF+8j7M1eJKGY33F4b5gfpIf1ZXVc05tcWump35w==
X-YMail-OSG: oNyXtVMVM1ni9yxIoYiFxz4jwE0HLXYkmWptIfGxBNcil_9xMGXVefimOQZF6.f
 my3G7LAs5KGdrurgy2IgRZn4MYAWLTaaEYIoLYpS9md3K0GzjNje13a2KkvCfB_Lt442qkMmGdJt
 myzjxAGOSNWNmeGKKRDwrUkyoxzuXzGJ9whask5O0KXvNCmeqoL6ey0LA.yDvQ06IdAT4n0A2IZY
 xA8Iuv04pi5sUIpKWvB4UTSsHGcTI4Pi16jnQrVshhUiLB1KOoNdydO6t2Ne15ZV_AP5XIYmZoUc
 vQktZmCjMO4hbgBhhOD5ql5WMFYVsc2E9_01GSqgK6Y5r34_ibpyJy7o0y0.TMplPiqmNaGYVdk0
 fSn6VGnvMQi8EHNx3.GOWVMNfEFpLIYyN_iEilOeAz7QybG0DHIHHIqKne1G2_ZcXu8xRcbbsNbC
 hDQESkxyqP1NNhO09Iu4yMArIcK_7s3qVrPvfFSpbLnCxDhCKq9FAKvArovL6_MKaIfA_GzW0oxP
 3HSKv_sFSxmfA_6p7l91IRdLe70y8WZMnS8mgITDjCYBO9nie1D3SEyH93mex.l6n9am4a8s2Nru
 iqD_DgshQvsBF5ZSbP316E8oklz6KloGyWrvxIwcyjyLayhLCTvOTa2cgqLXL0.Mc_XyD1UMpg8Q
 jr2bW.fn6SqwBnlSRczxuTWni1oBRIMH7pkGXWJ2dH19XAyqOajq4WKf5oT3xbbO1.Cb5wTWJ4oq
 rvt5bR5QkxKq4m7Jw3FSP9ikmYuVPhDCE1J_YeTD2FRTp5H6ez.vICT6lwAFSTgTMj.XIwNlIEzI
 yulVwoIdZbwPBTtkKLMUwMD7y0FDeL2ymNOXJnSVRVHIRrin8zr4Ss5woypxFd._W37g8GlvOq2f
 eATKU_ibWAOtQORe0cCyfoeJBeODUC.CLdcjGQ9WP2q8ldZpwNoKfNM0Ulzqx4d_2B43Mr5wsTKt
 XDMCaWycEP4AcNtCbVtfrCE9kwYytbQIY7vngpDrodBoVmhR_m1qoPneatUgSmXxG_6yG3ri2uME
 MSRkIW1aap6oX0nIf6XR1t2Vq5tKdQKo8UX_cFCEGaUJb6aSWwAPFxGTogOGqetdfxmm4VJZyTcU
 AH1BTlxtIv_l0XQ5uTLz078mJfBlstTK0XSjD1WVONOpQwhfHhq_93Cug5LLkBDB139LeWa8F_ZY
 w5OZmm.3eBEu.ZHbDzkr4oiUR7fdHEeJJNVdCNlhnLHxkzj8G2VGsAHAkSDXvMN0lmk49J7Zfc0f
 Rx0SwTsbuxBHZs4nWvTZPBdlnwJhsNSBIAHt0uz8XNscYmq45cA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 1 Aug 2019 19:39:16 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 432145fff8c09f95a0cbb5d15b2f0b52;
          Thu, 01 Aug 2019 19:39:14 +0000 (UTC)
To:     linux-nfs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Subject: Security labeling in NFS4 - who owns it?
Message-ID: <2d7f0c7e-a82a-5adb-df94-3ac4fa6b0dfe@schaufler-ca.com>
Date:   Thu, 1 Aug 2019 12:39:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As part of my work on LSM stacking I've encountered some issues with
the Linux implementation of NFS4 security labels. For example, the LFS
data is ignored, so even if the client and server are willing to identify=

the kind of information they are passing, the identity information isn't
available. The code asks if attributes requested are mandatory access
control attributes, but cannot differentiate between which of the possibl=
e
security attribute the other end is providing.

Is anyone actively owing the NFS labeling code? I'd like to bounce an
idea or two around before committing too much time to my ideas of
solutions.

=C2=A0


