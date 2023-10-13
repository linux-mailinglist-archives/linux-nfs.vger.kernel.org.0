Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9657C7D90
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJMGOd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMGOc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 02:14:32 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77F5395;
        Thu, 12 Oct 2023 23:14:29 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:12:40
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:12:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Clean up errors in export.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <75e4607f.958.18b27aa63f8.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D3Y3yhlsNvBAA--.689W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAJgADs4
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
ImZvbyAqCWJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGZzL25mc2QvZXhwb3J0LmggfCAxNCArKysr
KysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9uZnNkL2V4cG9ydC5oIGIvZnMvbmZzZC9leHBvcnQuaAppbmRl
eCAyZGY4YWUyNWFhZDMuLmQ0ZWQzMjRhYjEyMCAxMDA2NDQKLS0tIGEvZnMvbmZzZC9leHBvcnQu
aAorKysgYi9mcy9uZnNkL2V4cG9ydC5oCkBAIC02MiwxMyArNjIsMTMgQEAgc3RydWN0IGV4cG9y
dF9zdGF0cyB7CiAKIHN0cnVjdCBzdmNfZXhwb3J0IHsKIAlzdHJ1Y3QgY2FjaGVfaGVhZAloOwot
CXN0cnVjdCBhdXRoX2RvbWFpbiAqCWV4X2NsaWVudDsKKwlzdHJ1Y3QgYXV0aF9kb21haW4gICAg
ICpleF9jbGllbnQ7CiAJaW50CQkJZXhfZmxhZ3M7CiAJc3RydWN0IHBhdGgJCWV4X3BhdGg7CiAJ
a3VpZF90CQkJZXhfYW5vbl91aWQ7CiAJa2dpZF90CQkJZXhfYW5vbl9naWQ7CiAJaW50CQkJZXhf
ZnNpZDsKLQl1bnNpZ25lZCBjaGFyICoJCWV4X3V1aWQ7IC8qIDE2IGJ5dGUgZnNpZCAqLworCXVu
c2lnbmVkIGNoYXIgICAgICAgICAgKmV4X3V1aWQ7IC8qIDE2IGJ5dGUgZnNpZCAqLwogCXN0cnVj
dCBuZnNkNF9mc19sb2NhdGlvbnMgZXhfZnNsb2NzOwogCXVpbnQzMl90CQlleF9uZmxhdm9yczsK
IAlzdHJ1Y3QgZXhwX2ZsYXZvcl9pbmZvCWV4X2ZsYXZvcnNbTUFYX1NFQ0lORk9fTElTVF07CkBA
IC04Nyw3ICs4Nyw3IEBAIHN0cnVjdCBzdmNfZXhwb3J0IHsKIHN0cnVjdCBzdmNfZXhwa2V5IHsK
IAlzdHJ1Y3QgY2FjaGVfaGVhZAloOwogCi0Jc3RydWN0IGF1dGhfZG9tYWluICoJZWtfY2xpZW50
OworCXN0cnVjdCBhdXRoX2RvbWFpbiAgICAgKmVrX2NsaWVudDsKIAlpbnQJCQlla19mc2lkdHlw
ZTsKIAl1MzIJCQlla19mc2lkWzZdOwogCkBAIC0xMDgsMTEgKzEwOCwxMSBAQCBfX2JlMzIgY2hl
Y2tfbmZzZF9hY2Nlc3Moc3RydWN0IHN2Y19leHBvcnQgKmV4cCwgc3RydWN0IHN2Y19ycXN0ICpy
cXN0cCk7CiBpbnQJCQluZnNkX2V4cG9ydF9pbml0KHN0cnVjdCBuZXQgKik7CiB2b2lkCQkJbmZz
ZF9leHBvcnRfc2h1dGRvd24oc3RydWN0IG5ldCAqKTsKIHZvaWQJCQluZnNkX2V4cG9ydF9mbHVz
aChzdHJ1Y3QgbmV0ICopOwotc3RydWN0IHN2Y19leHBvcnQgKglycXN0X2V4cF9nZXRfYnlfbmFt
ZShzdHJ1Y3Qgc3ZjX3Jxc3QgKiwKK3N0cnVjdCBzdmNfZXhwb3J0ICAgICAgKnJxc3RfZXhwX2dl
dF9ieV9uYW1lKHN0cnVjdCBzdmNfcnFzdCAqLAogCQkJCQkgICAgIHN0cnVjdCBwYXRoICopOwot
c3RydWN0IHN2Y19leHBvcnQgKglycXN0X2V4cF9wYXJlbnQoc3RydWN0IHN2Y19ycXN0ICosCitz
dHJ1Y3Qgc3ZjX2V4cG9ydCAgICAgICpycXN0X2V4cF9wYXJlbnQoc3RydWN0IHN2Y19ycXN0ICos
CiAJCQkJCXN0cnVjdCBwYXRoICopOwotc3RydWN0IHN2Y19leHBvcnQgKglycXN0X2ZpbmRfZnNp
ZHplcm9fZXhwb3J0KHN0cnVjdCBzdmNfcnFzdCAqKTsKK3N0cnVjdCBzdmNfZXhwb3J0ICAgICAg
KnJxc3RfZmluZF9mc2lkemVyb19leHBvcnQoc3RydWN0IHN2Y19ycXN0ICopOwogaW50CQkJZXhw
X3Jvb3RmaChzdHJ1Y3QgbmV0ICosIHN0cnVjdCBhdXRoX2RvbWFpbiAqLAogCQkJCQljaGFyICpw
YXRoLCBzdHJ1Y3Qga25mc2RfZmggKiwgaW50IG1heHNpemUpOwogX19iZTMyCQkJZXhwX3BzZXVk
b3Jvb3Qoc3RydWN0IHN2Y19ycXN0ICosIHN0cnVjdCBzdmNfZmggKik7CkBAIC0xMjcsNiArMTI3
LDYgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qgc3ZjX2V4cG9ydCAqZXhwX2dldChzdHJ1Y3Qgc3Zj
X2V4cG9ydCAqZXhwKQogCWNhY2hlX2dldCgmZXhwLT5oKTsKIAlyZXR1cm4gZXhwOwogfQotc3Ry
dWN0IHN2Y19leHBvcnQgKiBycXN0X2V4cF9maW5kKHN0cnVjdCBzdmNfcnFzdCAqLCBpbnQsIHUz
MiAqKTsKK3N0cnVjdCBzdmNfZXhwb3J0ICpycXN0X2V4cF9maW5kKHN0cnVjdCBzdmNfcnFzdCAq
LCBpbnQsIHUzMiAqKTsKIAogI2VuZGlmIC8qIE5GU0RfRVhQT1JUX0ggKi8KLS0gCjIuMTcuMQo=

