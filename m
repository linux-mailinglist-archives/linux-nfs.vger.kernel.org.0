Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9522743FA4
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjF3QXH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjF3QXG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 12:23:06 -0400
X-Greylist: delayed 21256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 09:23:04 PDT
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7833E5E;
        Fri, 30 Jun 2023 09:23:04 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id F1E235ED70;
        Fri, 30 Jun 2023 19:22:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vMROMcFDV0U0-m4ZS9JB6;
        Fri, 30 Jun 2023 19:22:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688142179;
        bh=mv9+96IjNnE9RA4/nysPSS6WWMtg0mIxBYV6wh4+uBU=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=bcrFWFZcRIRwHkYq3HuC7SsbemHKohQtnvdSx9krkcuGcRXYbOMmd6balkfw0P/y8
         /yz47zIBoxr4V729z9P4mU6tLl/6lVjDGp9vEQcs8/yVAB3S/y8q1w0UVXzQl3jbrg
         XD9Oyuoj1sbdXtu16LbHPClUPUBennvFjpdNMs+k=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0ce62702-9a2f-4916-d0eb-4de3896e137b@yandex.ru>
Date:   Fri, 30 Jun 2023 19:22:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
References: <2390fdc8-13fa-4456-ab67-44f0744db412@moroto.mountain>
 <ac54a100-9e7f-47bf-a415-ca3784c08b1e@kadam.mountain>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] SUNRPC: clean up integer overflow check
In-Reply-To: <ac54a100-9e7f-47bf-a415-ca3784c08b1e@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gNi8zMC8yMyAxNToxMywgRGFuIENhcnBlbnRlciB3cm90ZToNCg0KPiBTbyBoZXJlIHdl
IGhhdmU6DQo+IA0KPiAJaWYgKHUzMl92YWwgPiBTT01FVEhJTkcpIHsNCj4gDQo+IFRoZSBj
b25kaXRpb24gaXMgaW1wb3NzaWJsZSB3aGVuIHRoZSBjb2RlIGlzIGNvbXBpbGVkIG9uIGEg
NjQtYml0DQo+IHN5c3RlbQ0KDQpUaGlzIGlzIGV4YWN0bHkgd2hhdCB0aGUgY29tcGlsZXJz
IHdhcm5zIGFib3V0Og0KDQokIGNhdCB0ZXN0LmMNCiNpbmNsdWRlIDxzdGRpbnQuaD4NCg0K
aW50IGYgKGludCAqcCwgdW5zaWduZWQgbikNCnsNCiAgIHJldHVybiBuID4gU0laRV9NQVgg
LyBzaXplb2YgKCpwKTsNCn0NCiQgZ2NjIC1XZXh0cmEgLWMgdGVzdC5jDQp0ZXN0LmM6IElu
IGZ1bmN0aW9uIOKAmGbigJk6DQp0ZXN0LmM6NToxMjogd2FybmluZzogY29tcGFyaXNvbiBp
cyBhbHdheXMgZmFsc2UgZHVlIHRvIGxpbWl0ZWQgcmFuZ2Ugb2YgZGF0YSB0eXBlIFstV3R5
cGUtbGltaXRzXQ0KICAgICA1IHwgICByZXR1cm4gbiA+IFNJWkVfTUFYIC8gc2l6ZW9mICgq
cCk7DQogICAgICAgfCAgICAgICAgICAgIF4NCiQgZ2NjIC1tMzIgLVdleHRyYSAtYyB0ZXN0
LmMNCiQgY2xhbmcgLVdleHRyYSAtYyB0ZXN0LmMNCnRlc3QuYzo1OjEyOiB3YXJuaW5nOiBy
ZXN1bHQgb2YgY29tcGFyaXNvbiBvZiBjb25zdGFudCA0NjExNjg2MDE4NDI3Mzg3OTAzIHdp
dGggZXhwcmVzc2lvbiBvZiB0eXBlICd1bnNpZ25lZCBpbnQnIGlzIGFsd2F5cyBmYWxzZSBb
LVd0YXV0b2xvZ2ljYWwtY29uc3RhbnQtb3V0LW9mLXJhbmdlLWNvbXBhcmVdDQogICByZXR1
cm4gbiA+IFNJWkVfTUFYIC8gc2l6ZW9mICgqcCk7DQogICAgICAgICAgfiBeIH5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCjEgd2FybmluZyBnZW5lcmF0ZWQuDQokIGNsYW5nIC1tMzIgLVdl
eHRyYSAtYyB0ZXN0LmMNCiQNCg0KV2hlcmUgaXMgYSBidWcgaGVyZT8gV2hhdCB0aGUgY29t
cGlsZXIgZGV2ZWxvcGVycyBhcmUgaW50ZW5kZWQgdG8gZml4Pw0KSG93IHRoZSBjb21waWxl
cnMgc2hvdWxkIGJlaGF2ZSBpbiB0aGlzIGNhc2U/DQoNCkRtaXRyeQ0KDQoNCg==
