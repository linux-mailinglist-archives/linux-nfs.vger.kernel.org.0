Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B217B10F3
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjI1Cts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Cts (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 22:49:48 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BEA794;
        Wed, 27 Sep 2023 19:49:44 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 10:48:22
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 10:48:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Clean up errors in xdr.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1d65e344.8a6.18ad9aff80a.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD926RRlgX6+AA--.635W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAssU
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcg
V2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBmcy9uZnNkL3hkci5oIHwgMTQgKysrKysr
Ky0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvbmZzZC94ZHIuaCBiL2ZzL25mc2QveGRyLmgKaW5kZXggODUyZjcx
NTgwYmQwLi5lMjc5N2ViMjY2OGQgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QveGRyLmgKKysrIGIvZnMv
bmZzZC94ZHIuaApAQCAtMTksNyArMTksNyBAQCBzdHJ1Y3QgbmZzZF9zYXR0cmFyZ3MgewogCiBz
dHJ1Y3QgbmZzZF9kaXJvcGFyZ3MgewogCXN0cnVjdCBzdmNfZmgJCWZoOwotCWNoYXIgKgkJCW5h
bWU7CisJY2hhciAgICAgICAgICAgICAgICAgICAqbmFtZTsKIAl1bnNpZ25lZCBpbnQJCWxlbjsK
IH07CiAKQEAgLTM4LDMyICszOCwzMiBAQCBzdHJ1Y3QgbmZzZF93cml0ZWFyZ3MgewogCiBzdHJ1
Y3QgbmZzZF9jcmVhdGVhcmdzIHsKIAlzdHJ1Y3Qgc3ZjX2ZoCQlmaDsKLQljaGFyICoJCQluYW1l
OworCWNoYXIgICAgICAgICAgICAgICAgICAgKm5hbWU7CiAJdW5zaWduZWQgaW50CQlsZW47CiAJ
c3RydWN0IGlhdHRyCQlhdHRyczsKIH07CiAKIHN0cnVjdCBuZnNkX3JlbmFtZWFyZ3MgewogCXN0
cnVjdCBzdmNfZmgJCWZmaDsKLQljaGFyICoJCQlmbmFtZTsKKwljaGFyIAkJICAgICAgICpmbmFt
ZTsKIAl1bnNpZ25lZCBpbnQJCWZsZW47CiAJc3RydWN0IHN2Y19maAkJdGZoOwotCWNoYXIgKgkJ
CXRuYW1lOworCWNoYXIgCQkgICAgICAgKnRuYW1lOwogCXVuc2lnbmVkIGludAkJdGxlbjsKIH07
CiAKIHN0cnVjdCBuZnNkX2xpbmthcmdzIHsKIAlzdHJ1Y3Qgc3ZjX2ZoCQlmZmg7CiAJc3RydWN0
IHN2Y19maAkJdGZoOwotCWNoYXIgKgkJCXRuYW1lOworCWNoYXIgCQkgICAgICAgKnRuYW1lOwog
CXVuc2lnbmVkIGludAkJdGxlbjsKIH07CiAKIHN0cnVjdCBuZnNkX3N5bWxpbmthcmdzIHsKIAlz
dHJ1Y3Qgc3ZjX2ZoCQlmZmg7Ci0JY2hhciAqCQkJZm5hbWU7CisJY2hhciAgCQkgICAgICAgKmZu
YW1lOwogCXVuc2lnbmVkIGludAkJZmxlbjsKLQljaGFyICoJCQl0bmFtZTsKKwljaGFyIAkJICAg
ICAgICp0bmFtZTsKIAl1bnNpZ25lZCBpbnQJCXRsZW47CiAJc3RydWN0IGlhdHRyCQlhdHRyczsK
IAlzdHJ1Y3Qga3ZlYwkJZmlyc3Q7Ci0tIAoyLjE3LjEK
