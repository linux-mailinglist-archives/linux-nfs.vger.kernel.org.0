Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713157C7D62
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJMGCn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 02:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJMGCl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 02:02:41 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7E58DD;
        Thu, 12 Oct 2023 23:02:39 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:00:53
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:00:53 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Clean up errors in filecache.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3265d6da.955.18b279f9aa9.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD8V3ShldtvBAA--.749W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAksg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9m
Zi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZnMvbmZzZC9maWxl
Y2FjaGUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2ZzL25mc2QvZmlsZWNhY2hlLmMgYi9mcy9uZnNkL2ZpbGVjYWNo
ZS5jCmluZGV4IGVmMDYzZjkzZmRlOS4uZjNhYWJjNmE5Zjk4IDEwMDY0NAotLS0gYS9mcy9uZnNk
L2ZpbGVjYWNoZS5jCisrKyBiL2ZzL25mc2QvZmlsZWNhY2hlLmMKQEAgLTQxMiw3ICs0MTIsNyBA
QCBuZnNkX2ZpbGVfZGlzcG9zZV9saXN0KHN0cnVjdCBsaXN0X2hlYWQgKmRpc3Bvc2UpCiBzdGF0
aWMgdm9pZAogbmZzZF9maWxlX2Rpc3Bvc2VfbGlzdF9kZWxheWVkKHN0cnVjdCBsaXN0X2hlYWQg
KmRpc3Bvc2UpCiB7Ci0Jd2hpbGUoIWxpc3RfZW1wdHkoZGlzcG9zZSkpIHsKKwl3aGlsZSAoIWxp
c3RfZW1wdHkoZGlzcG9zZSkpIHsKIAkJc3RydWN0IG5mc2RfZmlsZSAqbmYgPSBsaXN0X2ZpcnN0
X2VudHJ5KGRpc3Bvc2UsCiAJCQkJCQlzdHJ1Y3QgbmZzZF9maWxlLCBuZl9scnUpOwogCQlzdHJ1
Y3QgbmZzZF9uZXQgKm5uID0gbmV0X2dlbmVyaWMobmYtPm5mX25ldCwgbmZzZF9uZXRfaWQpOwot
LSAKMi4xNy4xCg==
