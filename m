Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AFC7C7BED
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 05:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjJMDOd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDOc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 23:14:32 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5604291;
        Thu, 12 Oct 2023 20:14:30 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:12:48
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 11:12:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Clean up errors in nfs_page.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2f52e71b.943.18b2705b8cb.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD+wtShlPtjBAA--.744W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAKsO
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeE8pCgpTaWduZWQtb2ZmLWJ5OiBK
aWFuZ0h1aSBYdSA8eHVqaWFuZ2h1aUBjZGpybGMuY29tPgotLS0KIGluY2x1ZGUvbGludXgvbmZz
X3BhZ2UuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZzX3BhZ2UuaCBiL2luY2x1ZGUvbGlu
dXgvbmZzX3BhZ2UuaAppbmRleCAxYzMxNWY4NTRlYTguLjZhM2M1NGJkMmM0MCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9uZnNfcGFnZS5oCisrKyBiL2luY2x1ZGUvbGludXgvbmZzX3BhZ2Uu
aApAQCAtMTIyLDcgKzEyMiw3IEBAIHN0cnVjdCBuZnNfcGFnZWlvX2Rlc2NyaXB0b3IgewogLyog
YXJiaXRyYXJpbHkgc2VsZWN0ZWQgbGltaXQgdG8gbnVtYmVyIG9mIG1pcnJvcnMgKi8KICNkZWZp
bmUgTkZTX1BBR0VJT19ERVNDUklQVE9SX01JUlJPUl9NQVggMTYKIAotI2RlZmluZSBORlNfV0JB
Q0tfQlVTWShyZXEpCSh0ZXN0X2JpdChQR19CVVNZLCYocmVxKS0+d2JfZmxhZ3MpKQorI2RlZmlu
ZSBORlNfV0JBQ0tfQlVTWShyZXEpCSh0ZXN0X2JpdChQR19CVVNZLCAmKHJlcSktPndiX2ZsYWdz
KSkKIAogZXh0ZXJuIHN0cnVjdCBuZnNfcGFnZSAqbmZzX3BhZ2VfY3JlYXRlX2Zyb21fcGFnZShz
dHJ1Y3QgbmZzX29wZW5fY29udGV4dCAqY3R4LAogCQkJCQkJICBzdHJ1Y3QgcGFnZSAqcGFnZSwK
LS0gCjIuMTcuMQo=
