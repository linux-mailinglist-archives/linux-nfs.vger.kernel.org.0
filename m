Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C547B10DD
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 04:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI1CjM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 22:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1CjM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 22:39:12 -0400
X-Greylist: delayed 139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 19:39:08 PDT
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C51E94
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 19:39:08 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 10:35:16
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 10:35:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Clean up errors in stats.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2078d5a0.8a4.18ad9a3f87c.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD9k5hRl1Hy+AA--.689W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAisa
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBL
YWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZnMvbmZzZC9zdGF0cy5jIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZnMvbmZzZC9zdGF0cy5jIGIvZnMvbmZzZC9zdGF0cy5jCmluZGV4IDYzNzk3NjM1
ZTFjMy4uODkxNDQ0NWRhZmI4IDEwMDY0NAotLS0gYS9mcy9uZnNkL3N0YXRzLmMKKysrIGIvZnMv
bmZzZC9zdGF0cy5jCkBAIC02MCw3ICs2MCw3IEBAIHN0YXRpYyBpbnQgbmZzZF9zaG93KHN0cnVj
dCBzZXFfZmlsZSAqc2VxLCB2b2lkICp2KQogI2lmZGVmIENPTkZJR19ORlNEX1Y0CiAJLyogU2hv
dyBjb3VudCBmb3IgaW5kaXZpZHVhbCBuZnN2NCBvcGVyYXRpb25zICovCiAJLyogV3JpdGluZyBv
cGVyYXRpb24gbnVtYmVycyAwIDEgMiBhbHNvIGZvciBtYWludGFpbmluZyB1bmlmb3JtaXR5ICov
Ci0Jc2VxX3ByaW50ZihzZXEsInByb2M0b3BzICV1IiwgTEFTVF9ORlM0X09QICsgMSk7CisJc2Vx
X3ByaW50ZihzZXEsICJwcm9jNG9wcyAldSIsIExBU1RfTkZTNF9PUCArIDEpOwogCWZvciAoaSA9
IDA7IGkgPD0gTEFTVF9ORlM0X09QOyBpKyspIHsKIAkJc2VxX3ByaW50ZihzZXEsICIgJWxsZCIs
CiAJCQkgICBwZXJjcHVfY291bnRlcl9zdW1fcG9zaXRpdmUoJm5mc2RzdGF0cy5jb3VudGVyW05G
U0RfU1RBVFNfTkZTNF9PUChpKV0pKTsKLS0gCjIuMTcuMQoK
