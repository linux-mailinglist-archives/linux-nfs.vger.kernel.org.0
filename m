Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E71B7C7D9E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 08:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJMGUX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 02:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMGUX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 02:20:23 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A980195;
        Thu, 12 Oct 2023 23:20:21 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:18:36
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:18:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Clean up errors in nfssvc.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5cdd6c2.959.18b27afd349.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD884ShlzdvBAA--.686W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAJgAIsz
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
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwpFUlJPUjogZG8g
bm90IGluaXRpYWxpc2Ugc3RhdGljcyB0byAwCgpTaWduZWQtb2ZmLWJ5OiBHdW9IdWEgQ2hlbmcg
PGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBmcy9uZnNkL25mc3N2Yy5jIHwgNiArKystLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZnMvbmZzZC9uZnNzdmMuYyBiL2ZzL25mc2QvbmZzc3ZjLmMKaW5kZXggY2UyNzNjNDA5YWI2
Li42YWVlZDBhMzlhODcgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvbmZzc3ZjLmMKKysrIGIvZnMvbmZz
ZC9uZnNzdmMuYwpAQCAtMjA4LDcgKzIwOCw3IEBAIGludCBuZnNkX3ZlcnMoc3RydWN0IG5mc2Rf
bmV0ICpubiwgaW50IHZlcnMsIGVudW0gdmVyc19vcCBjaGFuZ2UpCiB7CiAJaWYgKHZlcnMgPCBO
RlNEX01JTlZFUlMgfHwgdmVycyA+PSBORlNEX05SVkVSUykKIAkJcmV0dXJuIDA7Ci0Jc3dpdGNo
KGNoYW5nZSkgeworCXN3aXRjaCAoY2hhbmdlKSB7CiAJY2FzZSBORlNEX1NFVDoKIAkJaWYgKG5u
LT5uZnNkX3ZlcnNpb25zKQogCQkJbm4tPm5mc2RfdmVyc2lvbnNbdmVyc10gPSBuZnNkX3N1cHBv
cnRfdmVyc2lvbih2ZXJzKTsKQEAgLTI0Niw3ICsyNDYsNyBAQCBpbnQgbmZzZF9taW5vcnZlcnNp
b24oc3RydWN0IG5mc2RfbmV0ICpubiwgdTMyIG1pbm9ydmVyc2lvbiwgZW51bSB2ZXJzX29wIGNo
YW5nZQogCSAgICBjaGFuZ2UgIT0gTkZTRF9BVkFJTCkKIAkJcmV0dXJuIC0xOwogCi0Jc3dpdGNo
KGNoYW5nZSkgeworCXN3aXRjaCAoY2hhbmdlKSB7CiAJY2FzZSBORlNEX1NFVDoKIAkJaWYgKG5u
LT5uZnNkNF9taW5vcnZlcnNpb25zKSB7CiAJCQluZnNkX3ZlcnMobm4sIDQsIE5GU0RfU0VUKTsK
QEAgLTMxMCw3ICszMTAsNyBAQCBzdGF0aWMgaW50IG5mc2RfaW5pdF9zb2NrcyhzdHJ1Y3QgbmV0
ICpuZXQsIGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMg
aW50IG5mc2RfdXNlcnMgPSAwOworc3RhdGljIGludCBuZnNkX3VzZXJzOwogCiBzdGF0aWMgaW50
IG5mc2Rfc3RhcnR1cF9nZW5lcmljKHZvaWQpCiB7Ci0tIAoyLjE3LjEK
