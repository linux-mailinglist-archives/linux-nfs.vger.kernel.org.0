Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11147F081D
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjKSRe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjKSRez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:34:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04CB3
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:34:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50930f126b1so4627541e87.3
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700415290; x=1701020090; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KMbTF0ikKUWGovaV133hZZX7Cm578fZD8/RNI19NobU=;
        b=J3MACyUIzCx4iLHMqtho4BvJRcmeMtixWfTxzrKJ7rRCryVaayTv2QI1P17Rk7LCQ8
         M1uF8HnCnqofGi7FkmMrkMr94VsuzFveO5UvgOGP9CY9SMwCtldlGNH5mxwuJvEc6hYD
         vrW/IzzR8kwyOOSHbayipyOJLNy5XHYTHNtn+EXAXi/37eDRDQWko2moRzveVXTPyUrX
         gWeiot9BDvnsLxMr/WtmJH8R5uL8O5qt4kS/5ihmwA9URYEq9wlqsk7XBRKu+0PNRgpy
         DjeqpLiYKeRfXWlWnzl91WlM+wE8biAWO1ElC0+oGq4Cch/ADMqzRlRAMpBYXzGoVTZq
         pmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415290; x=1701020090;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMbTF0ikKUWGovaV133hZZX7Cm578fZD8/RNI19NobU=;
        b=TqT391/g93DJwG10vQrrz8wG0BoEB/3xZCNJdD2ll/gWG90eTBNoUVXPxsCdtLzjwh
         3EXFMtTr5Va83ET6UCWnWJSKuGJ7y9o0GCZ980avJgRGSYgnP4E9jmRsIYOEctcKDgbV
         40T8Y1SC59qzvwjrdIzyHlHgiaHiIqSomcwkua1mmOqWIGVTLjP3lXBZx827+FGZkP7J
         sb3s1lZVjyjAGdzX4Z9Mm6TLRqGfccNZwPvIyVBf7Q2DuNQ6ViA0revaoA4oLuiPDVd/
         bwnJ1Qih951VUBwCC3H1musvULoP1EduC+/a58F864iWYzXPQ9eO5GaYJB/wX6Uq4sQ3
         UdRg==
X-Gm-Message-State: AOJu0YxCNQuLKWJL5XPVznk4khEca5iEjAZwl3Vffzcpt4+HVZ5NwhAL
        0ngeMADELOmAc3nR6KnthvtimAYo/Bt6WPW+8mk6w0zhkxM=
X-Google-Smtp-Source: AGHT+IGlr73/pW6yzRjteMlIzaXifqNFkjxrWaHun9vI5olaMsuaUyQeVKuAb8wlHf91pwJeeRxkp/ekBJrMHlu2Bek=
X-Received: by 2002:a19:ae17:0:b0:507:9f4c:b72 with SMTP id
 f23-20020a19ae17000000b005079f4c0b72mr3830018lfc.15.1700415289803; Sun, 19
 Nov 2023 09:34:49 -0800 (PST)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 18:34:13 +0100
Message-ID: <CALXu0UeicRDxKCS9n3NJR6jGu-4E7AS-vC3g=hRAtuw6g=vf=g@mail.gmail.com>
Subject: List archives gone?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good evening!

"defunct nfsv4 list archive" at https://linux-nfs.org/pipermail/nfsv4/
linked on the main page is gone. Why did that happen?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
