Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371F822BA0C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 01:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgGWXOo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 19:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXOn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 19:14:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81623C0619D3
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 16:14:43 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so5779364iln.1
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=G0wOdvYet1m3lF7neqDZvKOax1YPWwK9betSblg41OU=;
        b=m6G574eNThyKbT/ZHcVVgs+x60TfEV/jEUEVPJqfhirIa8cE0qa5fogV+7qihtRTcm
         Gwyh6x19PW30pVWcmgICN8X9dgGNQ6Cb1dGNQp/phPrZLDklZm1ARN5DvJgH0JkrmHrc
         MnUIyd0wKDenMXSOvC2TLTw4Fz91scmjYsd22a+ALEpJBnvXKj0/OjQs5aJb3cB6HSAY
         8l8Dcpy/QjYWogGXqrgOvxlq1BX1o3LgBcKShdyuPC9vjBxTUBLrRxO5vdsw/lL9rs8+
         /k3vl7wAVKQEuav4Ettsw6KJYbzh6uz1jlCKDZjFfOMDN0J/P/zEUufxtKjx8aejYL7B
         oQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=G0wOdvYet1m3lF7neqDZvKOax1YPWwK9betSblg41OU=;
        b=dsW/6h2JqMBC/ndN/Q7Yc71zNFTF+U3u3to12kBhCI3IBWiAqteDPWoeT6tD0nFuST
         mMimhjXwCPA6vZUjUJNXyyzuZPh/SaOpGa2cYeku/xkH1gmyt03WHU/RZcdv1WLdvG2G
         mTJDbx7Gtw08jL4CbQzQbPIuetpEKkYrf4YhBhkRlwCewocEMwDzsCpFAmjp8yh/lo6j
         2OgFp7Heewj/5XR47+fDyUWU7OmJqz4ujUpMub1Xw0adz/xjD0Z+6Q89jVQ0qWPRvzuI
         s6LMVdEnddm2tvzITKq/rv6ITxtJyMLMOQh9yrifduIqUsCN/Z3FqbM271YXTIyJtGfO
         6NhQ==
X-Gm-Message-State: AOAM53277drcn7zdULJiHSkcTWoy7AWUyqzRyPxIHhTYs3j0Focv+i/t
        z0JM+rvTC8PozD1afJr20uOoDnx7
X-Google-Smtp-Source: ABdhPJwVyoSNGcRtm5TIlkwu38zVs5Pg+yQwLHOGMiBXBKGHZks5cfGA6jptpd9iwjLTlk+M6hrMyA==
X-Received: by 2002:a92:8453:: with SMTP id l80mr7718685ild.83.1595546082515;
        Thu, 23 Jul 2020 16:14:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 13sm2149429ilj.81.2020.07.23.16.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 16:14:41 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06NNEbiY003335;
        Thu, 23 Jul 2020 23:14:38 GMT
Subject: [PATCH RFC 0/2] Fix problems with NFSv4 on krb5p
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Jul 2020 19:14:37 -0400
Message-ID: <159554528704.6546.6823326959131917327.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tiny series would address a couple of bugs in the recent commits
that fixed xdr_buf_trim(), namely:

  31c9590ae468 ("SUNRPC: Add "@len" parameter to gss_unwrap()")
  a7e429a6fa6d ("SUNRPC: Fix GSS privacy computation of auth->au_ralign")
  0a8e7b7d0846 ("SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()")")

Turns out 31c9590ae468 had a couple of problems that were introduced
by refactoring late, and therefore were not caught during testing. The
client-side problems are documented here:

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1886277

The first patch addresses the NFSv4/krb5p failures reported in that
bug. It is a straightforward and obvious fix.

When this fix is applied on the server, NFSv3/krb5p stops working.
Thus the second patch is also needed, but this patch is somewhat
more controversial. It's not clear to me how much of the "pad
adjustment" logic is still needed in unwrap_priv_data(), so I'm
asking for some quick but careful review of this proposed change.

---

Chuck Lever (2):
      SUNRPC: Set rcv_buf->len correctly in gss_unwrap_kerberos_v2()
      SUNRPC: Fix buf->len calculation in unwrap_priv_data()


 net/sunrpc/auth_gss/gss_krb5_wrap.c | 2 +-
 net/sunrpc/auth_gss/svcauth_gss.c   | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--
Chuck Lever

