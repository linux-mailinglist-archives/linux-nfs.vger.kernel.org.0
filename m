Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31B07C7D51
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJMF5p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 01:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJMF5o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 01:57:44 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A43ECB7;
        Thu, 12 Oct 2023 22:57:40 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 13:55:42
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 13:55:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Clean up errors in lockd.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <96b90fc.952.18b279add15.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D3e2yhlSdvBAA--.687W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAfsb
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCkVSUk9SOiBjb2RlIGluZGVu
dCBzaG91bGQgdXNlIHRhYnMgd2hlcmUgcG9zc2libGUKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGZzL25mc2QvbG9ja2QuYyB8IDQgKystLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9mcy9uZnNkL2xvY2tkLmMgYi9mcy9uZnNkL2xvY2tkLmMKaW5kZXggNDZhN2Y5YjgxM2U1
Li5hY2ZlZDIyODIyZmEgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvbG9ja2QuYworKysgYi9mcy9uZnNk
L2xvY2tkLmMKQEAgLTMzLDcgKzMzLDcgQEAgbmxtX2ZvcGVuKHN0cnVjdCBzdmNfcnFzdCAqcnFz
dHAsIHN0cnVjdCBuZnNfZmggKmYsIHN0cnVjdCBmaWxlICoqZmlscCwKIAlzdHJ1Y3Qgc3ZjX2Zo
CWZoOwogCiAJLyogbXVzdCBpbml0aWFsaXplIGJlZm9yZSB1c2luZyEgYnV0IG1heHNpemUgZG9l
c24ndCBtYXR0ZXIgKi8KLQlmaF9pbml0KCZmaCwwKTsKKwlmaF9pbml0KCZmaCwgMCk7CiAJZmgu
ZmhfaGFuZGxlLmZoX3NpemUgPSBmLT5zaXplOwogCW1lbWNweSgmZmguZmhfaGFuZGxlLmZoX3Jh
dywgZi0+ZGF0YSwgZi0+c2l6ZSk7CiAJZmguZmhfZXhwb3J0ID0gTlVMTDsKQEAgLTQyLDcgKzQy
LDcgQEAgbmxtX2ZvcGVuKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBuZnNfZmggKmYs
IHN0cnVjdCBmaWxlICoqZmlscCwKIAlhY2Nlc3MgfD0gTkZTRF9NQVlfTE9DSzsKIAluZnNlcnIg
PSBuZnNkX29wZW4ocnFzdHAsICZmaCwgU19JRlJFRywgYWNjZXNzLCBmaWxwKTsKIAlmaF9wdXQo
JmZoKTsKLSAJLyogV2UgcmV0dXJuIG5sbSBlcnJvciBjb2RlcyBhcyBubG0gZG9lc24ndCBrbm93
CisJLyogV2UgcmV0dXJuIG5sbSBlcnJvciBjb2RlcyBhcyBubG0gZG9lc24ndCBrbm93CiAJICog
YWJvdXQgbmZzZCwgYnV0IG5mc2QgZG9lcyBrbm93IGFib3V0IG5sbS4uCiAJICovCiAJc3dpdGNo
IChuZnNlcnIpIHsKLS0gCjIuMTcuMQo=
