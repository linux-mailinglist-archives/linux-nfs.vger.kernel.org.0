Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6B495F6F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380560AbiAUNHT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 08:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbiAUNHK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jan 2022 08:07:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B6C061574
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jan 2022 05:07:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o12so33672665lfu.12
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jan 2022 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fcVqyLeu75Npteb3N6VXa9h56htMTlLWPuAP8m+cNog=;
        b=G9VL5XNmNTe4jW6mEUcZza91PLEz7r2q/QYMIidZrpJSV88+N+cmigOQqretiL2IYJ
         u0BPRuDPHzIQvj1g2ZeFyYy11gz2pgD//SQmrn4y+x/Om7tD4Y1xdoLXWa4lI6krjAzo
         R8GQYRGDM6t9valOGuII4kuq1DtPS5O02RYo5zG3DEe9VNsHDKUp1VL/ueddxuDSQ1aP
         G3GOMo0V7wjKV75ew8uLy5n6Iw1JDLJEj5YzP1lFcNX5QsC9Xf9jDIoTgI/iKZnSvgd+
         ur8n0JphqX5bFnQsAg1wlIdRFCqDvizs9UBg0eTa0zyp8HurLTYeSm+IUm3BXQWzcclC
         4m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fcVqyLeu75Npteb3N6VXa9h56htMTlLWPuAP8m+cNog=;
        b=ojdVXGMjSzU76ED42S9Fk7y5LIcqn87r1nkh8NgDcv7GCtb4zFKQnUwl/QLvY+9/Ap
         92larSAOnr03IycHVcdXVml+xTWfTwjKgpvnqQQiuTlONeNJTNzWdqKVydtbVppYPh0t
         2RV1e0XMdGsVyoJ9EjM8pKNJZdldfOrbV8o4//E0pjLRwnYEi1IE9WrxvxBJTdcM2wqo
         jfGDi0iRRtzBzh555JC442l2CfnyuSHaFqPBr3I2QvY+dJyz/YoPeMJ7FlYrZg4nM+Fl
         l9SAgKK7H6LU7B7a9YkNgpnX8enbX3rxmXNiEeCbBLouFOY4w7M07Q8+IhOo7pLMaPie
         Q8lQ==
X-Gm-Message-State: AOAM533S/xsIpN4/X4oli6LLbciDNJm6La+SXSAM3OLxruFqdv3Q7v3N
        5bG1IhvMUuzlcNdsT0SE1B8wnAZ0Z40VlnJRCcAWzugQpUo=
X-Google-Smtp-Source: ABdhPJzTht9bZJnmZl0QsXAXpby9lkZ/BmamyHmnhKy1M78b1/o9XfXBWmIzjHWat3qa47pWAjtp7+2ET2UFpvyhB6Q=
X-Received: by 2002:a05:6512:c1f:: with SMTP id z31mr3661332lfu.613.1642770427858;
 Fri, 21 Jan 2022 05:07:07 -0800 (PST)
MIME-Version: 1.0
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Fri, 21 Jan 2022 15:06:57 +0200
Message-ID: <CANkgwes_79iE9MGvzGu_tLjNVZprTjTMNzohADRU6pw4Z3xC_w@mail.gmail.com>
Subject: [PATCH] pynfs minor: fixed Environment._maketree to use proper
 stateid during file write
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: multipart/mixed; boundary="000000000000cd177e05d6174b47"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000cd177e05d6174b47
Content-Type: text/plain; charset="UTF-8"



--000000000000cd177e05d6174b47
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Minor-fixed-Environment._maketree-used-by-init-to-us.patch"
Content-Disposition: attachment; 
	filename="0001-Minor-fixed-Environment._maketree-used-by-init-to-us.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kyof2xs20>
X-Attachment-Id: f_kyof2xs20

RnJvbSA2M2MwNzExZjljZDhmOGMwYWFmZjdkMDExNmE0MmI1MDAxYmRkY2QyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWb2xvZHlteXIgS2hvbWVua28gPEtob21lbmtvLlZvbG9keW15
ckBnbWFpbC5jb20+CkRhdGU6IEZyaSwgMjEgSmFuIDIwMjIgMTQ6NTI6MjggKzAyMDAKU3ViamVj
dDogW1BBVENIXSBNaW5vcjogZml4ZWQgRW52aXJvbm1lbnQuX21ha2V0cmVlICh1c2VkIGJ5IGlu
aXQpIHRvIHVzZQogcHJvcGVyIHN0YXRlaWQgZHVyaW5nIGZpbGUgd3JpdGUKCl9tYWtldHJlZSBp
cyBhIHBhcnQgb2YgZ2VuZXJpYyBpbml0IHNlcXVlbmNlIGZvciBzZXJ2ZXI0MXRlc3RzIHNvIHRo
ZSBjb2RlIHNob3VsZCBiZSBnZW5lcmljLgpVc2luZyB6ZXJvIHN0YXRlaWQgKHdoZW4gIm90aGVy
IiBhbmQgInNlcWlkIiBhcmUgYm90aCB6ZXJvLCB0aGUgc3RhdGVpZCBpcyB0cmVhdGVkCmFzIGEg
c3BlY2lhbCBhbm9ueW1vdXMgc3RhdGVpZCkgaXMgYSBzcGVjaWFsIHVzZS1jYXNlIG9mIGFub255
bW91cyBhY2Nlc3MKc28gaXQgbXVzdCBub3QgYmUgdXNlZCBkdXJpbmcgZ2VuZXJpYyBpbml0aWFs
aXphdGlvbi4KClNpZ25lZC1vZmYtYnk6IFZvbG9keW15ciBLaG9tZW5rbyA8S2hvbWVua28uVm9s
b2R5bXlyQGdtYWlsLmNvbT4KLS0tCiBuZnM0LjEvc2VydmVyNDF0ZXN0cy9lbnZpcm9ubWVudC5w
eSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL25mczQuMS9zZXJ2ZXI0MXRlc3RzL2Vudmlyb25tZW50LnB5IGIvbmZzNC4x
L3NlcnZlcjQxdGVzdHMvZW52aXJvbm1lbnQucHkKaW5kZXggMTRiMDkwMi4uMGI3Yzk3NiAxMDA2
NDQKLS0tIGEvbmZzNC4xL3NlcnZlcjQxdGVzdHMvZW52aXJvbm1lbnQucHkKKysrIGIvbmZzNC4x
L3NlcnZlcjQxdGVzdHMvZW52aXJvbm1lbnQucHkKQEAgLTE5OCw3ICsxOTgsNyBAQCBjbGFzcyBF
bnZpcm9ubWVudCh0ZXN0bW9kLkVudmlyb25tZW50KToKICAgICAgICAgICAgICAgICBsb2cud2Fy
bmluZygiY291bGQgbm90IGNyZWF0ZSAvJXMiICUgYicvJy5qb2luKHBhdGgpKQogICAgICAgICAj
IE1ha2UgZmlsZS1vYmplY3QgaW4gL3RyZWUKICAgICAgICAgZmgsIHN0YXRlaWQgPSBjcmVhdGVf
Y29uZmlybShzZXNzLCBiJ21ha2V0cmVlJywgdHJlZSArIFtiJ2ZpbGUnXSkKLSAgICAgICAgcmVz
ID0gd3JpdGVfZmlsZShzZXNzLCBmaCwgc2VsZi5maWxlZGF0YSkKKyAgICAgICAgcmVzID0gd3Jp
dGVfZmlsZShzZXNzLCBmaCwgc2VsZi5maWxlZGF0YSwgc3RhdGVpZD1zdGF0ZWlkKQogICAgICAg
ICBjaGVjayhyZXMsIG1zZz0iV3JpdGluZyBkYXRhIHRvIC8lcy9maWxlIiAlIGInLycuam9pbih0
cmVlKSkKICAgICAgICAgcmVzID0gY2xvc2VfZmlsZShzZXNzLCBmaCwgc3RhdGVpZCkKICAgICAg
ICAgY2hlY2socmVzKQotLSAKMi4yNS4xCgo=
--000000000000cd177e05d6174b47--
