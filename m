Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B67C7D74
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 08:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJMGIw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMGIw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 02:08:52 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0230595;
        Thu, 12 Oct 2023 23:08:49 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:07:04
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:07:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Clean up errors in nfs4idmap.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5ba63549.957.18b27a54514.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD+I3ihlltvBAA--.685W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAqsu
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
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VykKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCB1c2UgdGFicyB3aGVyZSBwb3NzaWJsZQpFUlJPUjogcmV0dXJuIGlzIG5vdCBh
IGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBmcy9uZnNkL25mczRpZG1hcC5j
IHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRpZG1hcC5jIGIvZnMvbmZzZC9uZnM0aWRt
YXAuYwppbmRleCA3YTgwNmFjMTNlMzEuLjRlNjU1MzhhNThmMCAxMDA2NDQKLS0tIGEvZnMvbmZz
ZC9uZnM0aWRtYXAuYworKysgYi9mcy9uZnNkL25mczRpZG1hcC5jCkBAIC0yMTIsNyArMjEyLDcg
QEAgaWR0b25hbWVfcGFyc2Uoc3RydWN0IGNhY2hlX2RldGFpbCAqY2QsIGNoYXIgKmJ1ZiwgaW50
IGJ1ZmxlbikKIAogCWlmIChidWZbYnVmbGVuIC0gMV0gIT0gJ1xuJykKIAkJcmV0dXJuICgtRUlO
VkFMKTsKLQlidWZbYnVmbGVuIC0gMV09ICdcMCc7CisJYnVmW2J1ZmxlbiAtIDFdID0gJ1wwJzsK
IAogCWJ1ZjEgPSBrbWFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCk7CiAJaWYgKGJ1ZjEgPT0g
TlVMTCkKQEAgLTMxMyw3ICszMTMsNyBAQCBzdGF0aWMgdm9pZAogbmFtZXRvaWRfcmVxdWVzdChz
dHJ1Y3QgY2FjaGVfZGV0YWlsICpjZCwgc3RydWN0IGNhY2hlX2hlYWQgKmNoLCBjaGFyICoqYnBw
LAogICAgIGludCAqYmxlbikKIHsKLSAJc3RydWN0IGVudCAqZW50ID0gY29udGFpbmVyX29mKGNo
LCBzdHJ1Y3QgZW50LCBoKTsKKwlzdHJ1Y3QgZW50ICplbnQgPSBjb250YWluZXJfb2YoY2gsIHN0
cnVjdCBlbnQsIGgpOwogCiAJcXdvcmRfYWRkKGJwcCwgYmxlbiwgZW50LT5hdXRobmFtZSk7CiAJ
cXdvcmRfYWRkKGJwcCwgYmxlbiwgZW50LT50eXBlID09IElETUFQX1RZUEVfR1JPVVAgPyAiZ3Jv
dXAiIDogInVzZXIiKTsKQEAgLTM4MSw3ICszODEsNyBAQCBuYW1ldG9pZF9wYXJzZShzdHJ1Y3Qg
Y2FjaGVfZGV0YWlsICpjZCwgY2hhciAqYnVmLCBpbnQgYnVmbGVuKQogCiAJaWYgKGJ1ZltidWZs
ZW4gLSAxXSAhPSAnXG4nKQogCQlyZXR1cm4gKC1FSU5WQUwpOwotCWJ1ZltidWZsZW4gLSAxXT0g
J1wwJzsKKwlidWZbYnVmbGVuIC0gMV0gPSAnXDAnOwogCiAJYnVmMSA9IGttYWxsb2MoUEFHRV9T
SVpFLCBHRlBfS0VSTkVMKTsKIAlpZiAoYnVmMSA9PSBOVUxMKQpAQCAtNDMxLDcgKzQzMSw3IEBA
IG5hbWV0b2lkX3BhcnNlKHN0cnVjdCBjYWNoZV9kZXRhaWwgKmNkLCBjaGFyICpidWYsIGludCBi
dWZsZW4pCiAJZXJyb3IgPSAwOwogb3V0OgogCWtmcmVlKGJ1ZjEpOwotCXJldHVybiAoZXJyb3Ip
OworCXJldHVybiBlcnJvcjsKIH0KIAogCi0tIAoyLjE3LjEK
