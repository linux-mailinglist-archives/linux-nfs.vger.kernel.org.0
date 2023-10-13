Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6A7C7DCC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 08:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJMGlj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMGli (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 02:41:38 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DED05BC;
        Thu, 12 Oct 2023 23:41:36 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 14:39:51
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 14:39:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Clean up errors in nfs4xdr.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <116353ed.95a.18b27c347d9.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD835ihlId7BAA--.750W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQABB2UlHDMAlgAEs6
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
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VikKRVJST1I6IGVsc2Ugc2hv
dWxkIGZvbGxvdyBjbG9zZSBicmFjZSAnfScKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8
d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBmcy9uZnNkL25mczR4ZHIuYyB8IDcgKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9mcy9uZnNkL25mczR4ZHIuYyBiL2ZzL25mc2QvbmZzNHhkci5jCmluZGV4IDFjYmQyYTM5
MjMwMi4uOGI5NzA3OTU3NjQ5IDEwMDY0NAotLS0gYS9mcy9uZnNkL25mczR4ZHIuYworKysgYi9m
cy9uZnNkL25mczR4ZHIuYwpAQCAtMjQzMiw3ICsyNDMyLDcgQEAgbmZzZDRfZGVjb2RlX2NvbXBv
dW5kKHN0cnVjdCBuZnNkNF9jb21wb3VuZGFyZ3MgKmFyZ3ApCiB7CiAJc3RydWN0IG5mc2Q0X29w
ICpvcDsKIAlib29sIGNhY2hldGhpcyA9IGZhbHNlOwotCWludCBhdXRoX3NsYWNrPSBhcmdwLT5y
cXN0cC0+cnFfYXV0aF9zbGFjazsKKwlpbnQgYXV0aF9zbGFjayA9IGFyZ3AtPnJxc3RwLT5ycV9h
dXRoX3NsYWNrOwogCWludCBtYXhfcmVwbHkgPSBhdXRoX3NsYWNrICsgODsgLyogb3BjbnQsIHN0
YXR1cyAqLwogCWludCByZWFkY291bnQgPSAwOwogCWludCByZWFkYnl0ZXMgPSAwOwpAQCAtMjU4
NSw3ICsyNTg1LDcgQEAgc3RhdGljIF9fYmUzMiBuZnNkNF9lbmNvZGVfY29tcG9uZW50c19lc2Mo
c3RydWN0IHhkcl9zdHJlYW0gKnhkciwgY2hhciBzZXAsCiAJX19iZTMyICpwOwogCV9fYmUzMiBw
YXRobGVuOwogCWludCBwYXRobGVuX29mZnNldDsKLQlpbnQgc3RybGVuLCBjb3VudD0wOworCWlu
dCBzdHJsZW4sIGNvdW50ID0gMDsKIAljaGFyICpzdHIsICplbmQsICpuZXh0OwogCiAJZHByaW50
aygibmZzZDRfZW5jb2RlX2NvbXBvbmVudHMoJXMpXG4iLCBjb21wb25lbnRzKTsKQEAgLTI2MjIs
OCArMjYyMiw3IEBAIHN0YXRpYyBfX2JlMzIgbmZzZDRfZW5jb2RlX2NvbXBvbmVudHNfZXNjKHN0
cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIGNoYXIgc2VwLAogCQkJCXJldHVybiBuZnNlcnJfcmVzb3Vy
Y2U7CiAJCQlwID0geGRyX2VuY29kZV9vcGFxdWUocCwgc3RyLCBzdHJsZW4pOwogCQkJY291bnQr
KzsKLQkJfQotCQllbHNlCisJCX0gZWxzZQogCQkJZW5kKys7CiAJCWlmIChmb3VuZF9lc2MpCiAJ
CQllbmQgPSBuZXh0OwotLSAKMi4xNy4xCg==
