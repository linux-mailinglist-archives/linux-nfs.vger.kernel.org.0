Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C700D4C19EA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiBWRcW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiBWRcV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 12:32:21 -0500
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE73584D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:31:52 -0800 (PST)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id C0E8312837;
        Wed, 23 Feb 2022 18:31:49 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-168-136.nc.de [89.0.168.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA id 04AEA11F13;
        Wed, 23 Feb 2022 18:31:44 +0100 (CET)
Received: from [192.168.155.203] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 38E25B3B0027;
        Wed, 23 Feb 2022 18:31:35 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------3KzMwLctDLE5c6vZGYtRFApR"
Message-ID: <53040065-a88b-1b60-3430-27d2acd761b7@garloff.de>
Date:   Wed, 23 Feb 2022 18:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
 <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
 <CAN-5tyHC0m8nLgEi89EdKUo-kpEWsi-LUNHqAXc=gBzW+u52NA@mail.gmail.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
In-Reply-To: <CAN-5tyHC0m8nLgEi89EdKUo-kpEWsi-LUNHqAXc=gBzW+u52NA@mail.gmail.com>
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 04AEA11F13
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------3KzMwLctDLE5c6vZGYtRFApR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olga,

thanks for coming back!

On 23.02.22 15:22, Olga Kornievskaia wrote:
> Hi Kurt,
> I apologize for the late response. I have looked at the network trace.
> The problem stems from the broken server that claims to support
> fs_locations but then decides to never reply to the query.
>
> I can implement a mount option to say fs_locquery=off to handle mounts
> against the broken servers?
>
> However I would like to ask if the better path forward isn't to update
> to the knfsd where the problem is fixed?

Well, I have ran self-compiled kernels on Qnap appliances before (to
work around Qnap's ext4 breakage when doing the case-independent
name lookup), but it was a painful and cumbersome process and I don't
want to repeat it. Appliances are not meant to use with custom
kernels.
Even if I do: This does not help many many other users ... Unless we
convince Qnap to provide patches for old appliances, we'll experience
breakage.

On my end, I have applied the attached patch, restricting the use
of FS_LOCATIONS to servers that advertize NFS v4.2 or later.

In the patch, you'll also see clearing the bit before it gets set.
This was spotted by seth, see
https://bbs.archlinux.org/viewtopic.php?pid=2023983#p2023983
In latest upstream kernels you'd also need to clear
NFS_CAP_CASE_PRESERVING | NFS_CAP_CASE_INSENSITIVE
so I wonder whether we should not just nullify the caps
bit field prior to testing and selectively setting flags.

With this patch, I can mount NFS volumes from Qnap knfsd
again without any special workarounds (such as nfsver=3 or the
to-be-implemented setting that you suggest). I have no idea
whether or not we leave a lot features behind by restricting
FS_LOCATIONS on the client side to servers >= NFS v4.2.
But certainly better than breaking in a -stable kernel update,
even if the server might be to blame.

Best,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

--------------3KzMwLctDLE5c6vZGYtRFApR
Content-Type: text/x-patch; charset=UTF-8;
 name="nfs-restrict-fs-loc-to-nfs42.diff"
Content-Disposition: attachment; filename="nfs-restrict-fs-loc-to-nfs42.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMKaW5k
ZXggMzg5ZmE3MmQ0Y2E5Li5mYzI5ZGFmMDBhNzIgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9uZnM0
cHJvYy5jCisrKyBiL2ZzL25mcy9uZnM0cHJvYy5jCkBAIC0zODgwLDggKzM4ODAsOCBAQCBz
dGF0aWMgaW50IF9uZnM0X3NlcnZlcl9jYXBhYmlsaXRpZXMoc3RydWN0IG5mc19zZXJ2ZXIg
KnNlcnZlciwgc3RydWN0IG5mc19maCAqZgogCQkJcmVzLmF0dHJfYml0bWFza1syXSAmPSBG
QVRUUjRfV09SRDJfTkZTNDJfTUFTSzsKIAkJfQogCQltZW1jcHkoc2VydmVyLT5hdHRyX2Jp
dG1hc2ssIHJlcy5hdHRyX2JpdG1hc2ssIHNpemVvZihzZXJ2ZXItPmF0dHJfYml0bWFzaykp
OwotCQlzZXJ2ZXItPmNhcHMgJj0gfihORlNfQ0FQX0FDTFMgfCBORlNfQ0FQX0hBUkRMSU5L
UyB8Ci0JCQkJICBORlNfQ0FQX1NZTUxJTktTfCBORlNfQ0FQX1NFQ1VSSVRZX0xBQkVMKTsK
KwkJc2VydmVyLT5jYXBzICY9IH4oTkZTX0NBUF9BQ0xTIHwgTkZTX0NBUF9IQVJETElOS1Mg
fCBORlNfQ0FQX1NZTUxJTktTCisJCQkJfCBORlNfQ0FQX1NFQ1VSSVRZX0xBQkVMIHwgTkZT
X0NBUF9GU19MT0NBVElPTlMpOwogCQlzZXJ2ZXItPmZhdHRyX3ZhbGlkID0gTkZTX0FUVFJf
RkFUVFJfVjQ7CiAJCWlmIChyZXMuYXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0FD
TCAmJgogCQkJCXJlcy5hY2xfYml0bWFzayAmIEFDTDRfU1VQUE9SVF9BTExPV19BQ0wpCkBA
IC0zODk0LDcgKzM4OTQsOCBAQCBzdGF0aWMgaW50IF9uZnM0X3NlcnZlcl9jYXBhYmlsaXRp
ZXMoc3RydWN0IG5mc19zZXJ2ZXIgKnNlcnZlciwgc3RydWN0IG5mc19maCAqZgogCQlpZiAo
cmVzLmF0dHJfYml0bWFza1syXSAmIEZBVFRSNF9XT1JEMl9TRUNVUklUWV9MQUJFTCkKIAkJ
CXNlcnZlci0+Y2FwcyB8PSBORlNfQ0FQX1NFQ1VSSVRZX0xBQkVMOwogI2VuZGlmCi0JCWlm
IChyZXMuYXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0ZTX0xPQ0FUSU9OUykKKwkJ
LyogUmVzdHJpY3QgRlNfTE9DQVRJT05TIHRvIE5GUyB2NC4yKyB0byB3b3JrIGFyb3VuZCBR
bmFwIGtuZnNkLTMuNC42IGJ1ZyAqLworCQlpZiAocmVzLmF0dHJfYml0bWFza1swXSAmIEZB
VFRSNF9XT1JEMF9GU19MT0NBVElPTlMgJiYgbWlub3J2ZXJzaW9uID49IDIpCiAJCQlzZXJ2
ZXItPmNhcHMgfD0gTkZTX0NBUF9GU19MT0NBVElPTlM7CiAJCWlmICghKHJlcy5hdHRyX2Jp
dG1hc2tbMF0gJiBGQVRUUjRfV09SRDBfRklMRUlEKSkKIAkJCXNlcnZlci0+ZmF0dHJfdmFs
aWQgJj0gfk5GU19BVFRSX0ZBVFRSX0ZJTEVJRDsK

--------------3KzMwLctDLE5c6vZGYtRFApR--
