Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637687B10F1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjI1Com (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 22:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjI1Col (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 22:44:41 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1530A1BC;
        Wed, 27 Sep 2023 19:44:30 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 10:43:04
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 10:43:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Clean up errors in nfs4state.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <65758e6b.8a5.18ad9ab1c3e.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD846BRlzH2+AA--.690W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAnsf
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VykKCkVSUk9SOiBzcGFjZSBy
ZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4TykKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJl
Zm9yZSB0aGF0ICd+JyAoY3R4Ok94VikKU2lnbmVkLW9mZi1ieTogS2FpTG9uZyBXYW5nIDx3YW5n
a2FpbG9uZ0BqYXJpLmNuPgotLS0KIGZzL25mc2QvbmZzNHN0YXRlLmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMKaW5kZXggOTg4NDI2YzM2
Y2FkLi40ZGRkOTY2NGY0YjMgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMKKysrIGIv
ZnMvbmZzZC9uZnM0c3RhdGUuYwpAQCAtNTksNyArNTksNyBAQAogCiAjZGVmaW5lIE5GU0REQkdf
RkFDSUxJVFkgICAgICAgICAgICAgICAgTkZTRERCR19QUk9DCiAKLSNkZWZpbmUgYWxsX29uZXMg
e3t+MCx+MH0sfjB9CisjZGVmaW5lIGFsbF9vbmVzIHt7IH4wLCB+MH0sIH4wfQogc3RhdGljIGNv
bnN0IHN0YXRlaWRfdCBvbmVfc3RhdGVpZCA9IHsKIAkuc2lfZ2VuZXJhdGlvbiA9IH4wLAogCS5z
aV9vcGFxdWUgPSBhbGxfb25lcywKQEAgLTI5OCw3ICsyOTgsNyBAQCBmaW5kX29yX2FsbG9jYXRl
X2Jsb2NrKHN0cnVjdCBuZnM0X2xvY2tvd25lciAqbG8sIHN0cnVjdCBrbmZzZF9maCAqZmgsCiAK
IAluYmwgPSBmaW5kX2Jsb2NrZWRfbG9jayhsbywgZmgsIG5uKTsKIAlpZiAoIW5ibCkgewotCQlu
Ymw9IGttYWxsb2Moc2l6ZW9mKCpuYmwpLCBHRlBfS0VSTkVMKTsKKwkJbmJsID0ga21hbGxvYyhz
aXplb2YoKm5ibCksIEdGUF9LRVJORUwpOwogCQlpZiAobmJsKSB7CiAJCQlJTklUX0xJU1RfSEVB
RCgmbmJsLT5uYmxfbGlzdCk7CiAJCQlJTklUX0xJU1RfSEVBRCgmbmJsLT5uYmxfbHJ1KTsKLS0g
CjIuMTcuMQo=
