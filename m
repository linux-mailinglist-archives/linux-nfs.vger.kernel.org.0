Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB017B10FD
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 04:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjI1CxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 22:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CxT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 22:53:19 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0203694;
        Wed, 27 Sep 2023 19:53:17 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 10:51:55
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 10:51:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Clean up errors in nfs3proc.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <10df416a.8a7.18ad9b33756.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D1L6hRl0n6+AA--.635W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFAACs5
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
bmVlZCBjb25zaXN0ZW50IHNwYWNpbmcgYXJvdW5kICcrJyAoY3R4Old4VikKRVJST1I6IHNwYWNl
cyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPycgKGN0eDpWeFcpCgpTaWduZWQtb2ZmLWJ5OiBLYWlM
b25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZnMvbmZzZC9uZnMzcHJvYy5jIHwg
NCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzM3Byb2MuYyBiL2ZzL25mc2QvbmZzM3Byb2MuYwppbmRl
eCAyNjhlZjU3NzUxYzQuLjNkYzEzODZlMzBiYyAxMDA2NDQKLS0tIGEvZnMvbmZzZC9uZnMzcHJv
Yy5jCisrKyBiL2ZzL25mc2QvbmZzM3Byb2MuYwpAQCAtMTcxLDcgKzE3MSw3IEBAIG5mc2QzX3By
b2NfcmVhZChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQogCSAqICsgMSAoeGRyIG9wYXF1ZSBieXRl
IGNvdW50KSA9IDI2CiAJICovCiAJcmVzcC0+Y291bnQgPSBhcmdwLT5jb3VudDsKLQlzdmNfcmVz
ZXJ2ZV9hdXRoKHJxc3RwLCAoKDEgKyBORlMzX1BPU1RfT1BfQVRUUl9XT1JEUyArIDMpPDwyKSAr
IHJlc3AtPmNvdW50ICs0KTsKKwlzdmNfcmVzZXJ2ZV9hdXRoKHJxc3RwLCAoKDEgKyBORlMzX1BP
U1RfT1BfQVRUUl9XT1JEUyArIDMpPDwyKSArIHJlc3AtPmNvdW50ICsgNCk7CiAKIAlmaF9jb3B5
KCZyZXNwLT5maCwgJmFyZ3AtPmZoKTsKIAlyZXNwLT5zdGF0dXMgPSBuZnNkX3JlYWQocnFzdHAs
ICZyZXNwLT5maCwgYXJncC0+b2Zmc2V0LApAQCAtMTk0LDcgKzE5NCw3IEBAIG5mc2QzX3Byb2Nf
d3JpdGUoc3RydWN0IHN2Y19ycXN0ICpycXN0cCkKIAkJCQlTVkNGSF9mbXQoJmFyZ3AtPmZoKSwK
IAkJCQlhcmdwLT5sZW4sCiAJCQkJKHVuc2lnbmVkIGxvbmcgbG9uZykgYXJncC0+b2Zmc2V0LAot
CQkJCWFyZ3AtPnN0YWJsZT8gIiBzdGFibGUiIDogIiIpOworCQkJCWFyZ3AtPnN0YWJsZSA/ICIg
c3RhYmxlIiA6ICIiKTsKIAogCXJlc3AtPnN0YXR1cyA9IG5mc2Vycl9mYmlnOwogCWlmIChhcmdw
LT5vZmZzZXQgPiAodTY0KU9GRlNFVF9NQVggfHwKLS0gCjIuMTcuMQo=
