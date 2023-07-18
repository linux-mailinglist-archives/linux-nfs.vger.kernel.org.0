Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F1757208
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 04:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGRC5g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 22:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRC5f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 22:57:35 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 19:57:34 PDT
Received: from m13135.mail.163.com (m13135.mail.163.com [220.181.13.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1272A1B3
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=m/sgsFdx76adlQEi7HHVX7VSVBNXJGtijmgBxLRcu5s=; b=k
        yxPjBoXEM7ZAcutpKf61l9PbUJSR6YMCUPPX4HIy4IeSgeOeMC2jTzVo9it0g65M
        6oUUq2GcPph1m7vqzRAyEJKBP6FaCeOZKXaEIgYHdeikhzlDq2KGVSYsY17lHY+U
        uMUYcWxOQ6bZKJT1tOzQMPYlo4xaxaRsCjSuJPw9fE=
Received: from zhulei_szu$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr135 (Coremail) ; Tue, 18 Jul 2023 10:42:28 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Tue, 18 Jul 2023 10:42:28 +0800 (CST)
From:   zhulei <zhulei_szu@163.com>
To:     linux-nfs@vger.kernel.org
Subject: Question on nfs umount timeout
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuyTC/qft0kv7iScYOkWkkYagew/X8u3uv4k1IVePZE0sSz0wQYNe0RHI2XnyvOqIB6wiyO4YBNhxdtoZI9KdaxzdBWSuaqiogdwfjvcoqd+
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5a6cf12d.191e.18966e0afe0.Coremail.zhulei_szu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: h8GowAAHexIU_LVkgg0EAA--.29360W
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/1tbiHRSwTWI6+-lsTgAAsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

CkhpLAoKSSByZWNlbnRseSB0ZXN0ZWQgbmZzIGFuZCBmb3VuZCB0aGF0IGFmdGVyIGEgbmV0d29y
ayBmYWlsdXJlIG9uIHRoZSBzZXJ2ZXIsIHRoZSBjbGllbnQgdW1vdW50IHNoYXJlZCBmb2xkZXIg
ZXhwZXJpZW5jZWQgYSB0aW1lb3V0IHBoZW5vbWVub24sIGxhc3RpbmcKYXBwcm94aW1hdGVseSAx
MDAgc2Vjb25kcy4KClJlcHJvZHVjdGlvbiBtZXRob2Q6CmNsaWVudDoKbW91bnQgLXQgbmZzIHNl
cnZlcl9pcDpmb2xkZXIgZm9sZGVyIC1vIHNvZnQsdGltZW89MzAscmV0cnk9MyxpbnRyCgpBZnRl
ciBzdWNjZXNzZnVsbHkgbW91bnRpbmcsICAKc2VydmVyOgppZmNvbmZpZyBldGhlciBkb3duCgpj
bGllbnQ6CmRhdGUKdW1vdW50IGZvbGRlcgpkYXRlCgpBdCB0aGlzIHBvaW50LCB1bW91bnQgd2ls
bCBiZSBzdHVjayBmb3IgMTAwIHNlY29uZHMuCkJ5IGRlYnVnZ2luZywgaW4gdGhlIGNhbGxfdGlt
ZW91dCBmdW5jdGlvbiwgd2lsbCBlbnRlciB0aGUgZm9sbG93aW5nIHN0YXRlbWVudCBhbmQgZGly
ZWN0bHkgcmV0dXJuOgqjqGU0ZWM0OGQzY2M2MTM5ZjRjMWE5MzRmZjI1ZDQ0MGNkNGQ1MDI3OWaj
ulNVTlJQQzogTWFrZSAibm8gcmV0cmFucyB0aW1lb3V0IiBzb2Z0IHRhc2tzIGJlaGF2ZSBsaWtl
IHNvZnRjb25uIGZvciB0aW1lb3V0c6OpCgppZiAoKHRhc2stPnRrX2ZsYWdzICYgUlBDX1RBU0tf
Tk9fUkVUUkFOU19USU1FT1VUKSAmJgogICAgICBycGNfY2hlY2tfY29ubmVjdGVkKHRhc2stPnRr
X3Jxc3RwKSkgewoJCQlyZXR1cm47Cn0KCldoZW4gaSByZXZlcnQgdGhpcyBwYXRjaCBmb3IgdGVz
dGluZyBhbmQgZm91bmQgdGhhdCB0aGUgdW1vdW50IHRpbWUgd2FzIGFwcHJveGltYXRlbHkgMjAg
c2Vjb25kcy4KCkluIGFkZGl0aW9uLCBvcGVuaW5nIG5mcyBkZWJ1Z2dpbmcgd2lsbCByZXBlYXQg
dGhlIGZvbGxvd2luZyBsb2dzLCBlY2hvIDcgPiAvcHJvYy9zeXMvc3VucnBjL3JwY19kZWJ1ZzoK
ClsgMTEzMS4xMDAwNjJdIFJQQzogICAgNjEgY2FsbF90aW1lb3V0IChtaW5vcikKWyAxMTMxLjEw
MDA2Ml0gUlBDOiAgICA2MSBjYWxsX2JpbmQgKHN0YXR1cyAwKQpbIDExMzEuMTAwMDY0XSBSUEM6
ICAgIDYxIGNhbGxfY29ubmVjdCB4cHJ0IDAwMDAwMDAwMjVmYWUyYzUgaXMgY29ubmVjdGVkClsg
MTEzMS4xMDAwNjVdIFJQQzogICAgNjEgY2FsbF90cmFuc21pdCAoc3RhdHVzIDApClsgMTEzMS4x
MDAwNjVdIFJQQzogICAgNjEgeHBydF9wcmVwYXJlX3RyYW5zbWl0ClsgMTE0MC4zMTYwMDBdIFJQ
QzogICAgNjEgY2FsbF9zdGF0dXMgKHN0YXR1cyAtMTEwKQpbIDExNDAuMzE2MDAzXSBSUEM6ICAg
IDYxIGNhbGxfdGltZW91dCAobWFqb3IpClsgMTE0MC4zMTYwMDNdIFJQQzogICAgNjEgY2FsbF90
aW1lb3V0IChtaW5vcikKWyAxMTQwLjMxNjAwNF0gUlBDOiAgICA2MSBjYWxsX2JpbmQgKHN0YXR1
cyAwKQpbIDExNDAuMzE2MDA1XSBSUEM6ICAgIDYxIGNhbGxfY29ubmVjdCB4cHJ0IDAwMDAwMDAw
MjVmYWUyYzUgaXMgY29ubmVjdGVkClsgMTE0MC4zMTYwMDVdIFJQQzogICAgNjEgY2FsbF90cmFu
c21pdCAoc3RhdHVzIDApClsgMTE0MC4zMTYwMDZdIFJQQzogICAgNjEgeHBydF9wcmVwYXJlX3Ry
YW5zbWl0CgoKSSBhbSBuZXdlciB0byBuZnMsICBtYXkgSSBhc2sgd2hldGhlciB0aGlzIHRpbWVv
dXQgcGhlbm9tZW5vbiBpcyBhIG5vcm1hbKO/Cg==
