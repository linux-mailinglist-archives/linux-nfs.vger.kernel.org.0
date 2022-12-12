Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229D64A1CC
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiLLNp6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 08:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiLLNpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 08:45:31 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73D1570E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 05:44:48 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 4so6151223plj.3
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9QYk78iHNlSQRrkcLy5HQIC41HN6uklFQ6XNzadia/4=;
        b=a3YrWlpmZBKD7hqbRScF/1yPGm0p/81fgDItvHgr+bXN7TuA8EkKE+r+UKi1N6B5OW
         tPYhAPuz0mC5buVkpZm1yNai5fWtBKYpCEpIgEZhgtkzGHF9LxjZOlA+XZOYt/IU1Ype
         HTsmXOJ/rB1muoG2xtX/YooiGEoNWNsQL8ulmgeTFpKuuMgKT8tvH3OiPo5kJBYZ2gvD
         cNWhd6AMInjF1nswiSwIRi8p3MzRYnY2gHHPE7X29W3h8uguO7sOIbV1ABhosbF05N4F
         xrbFfaXxglOpXFIWaqo0tVbNhSpugijwNAxMa3/W+IUm+XRiIlm9p0lXvlxRg/Huq5OZ
         UsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QYk78iHNlSQRrkcLy5HQIC41HN6uklFQ6XNzadia/4=;
        b=WZTctG9jdV//1Remn83X2IqWpKHHdPw2Bi8UrHwd5QgIW5Sa2bvaIOmMnMhPEhOqNw
         JUxQf+7i0WLmhj8y5TwiwiCkLHla2+z+X8MB38qcBuA1AxjQ8E4ug2+pboMXG6WJvOf/
         PL8MXKzV6q5KRglWPL5sBi9PJyXBsPgEK8of+EIVWOd8RS5Ps9oI3zZEEbVPCtHDjzbO
         BbedYE4M4EegAmRy5l8ldd8iFHYJg0rLWsigMsxIa3HR877EPIeSCn1bHwX8uR08m5sP
         /NjLDq9zptcJZEXf3RHBD8kL0z4KO7Lqnn5LNKz8PqovJvCyPduBn6ZHG0cHUmL8xxMg
         1twA==
X-Gm-Message-State: ANoB5pmwhKABfqX92K+1zGCNl2O9/fhC2d8nMGb4QDYlYWj+/H1O5Ddp
        SUMKc5U0Ce+OX/3A1QsWLdBgwDIpgCz1Pp8zvJI+CtTLLInEmzjc
X-Google-Smtp-Source: AA0mqf5mad6uwHHqRfVy2c8QBgREDmT7tDKExwmZrLYnDlnuzDY3p1nyj0w68mZX6cR55iJNoSHKu9kZ/GG0Quhqyb4=
X-Received: by 2002:a17:902:f792:b0:186:b32c:4cdc with SMTP id
 q18-20020a170902f79200b00186b32c4cdcmr79808989pln.166.1670852688080; Mon, 12
 Dec 2022 05:44:48 -0800 (PST)
MIME-Version: 1.0
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <CALV6CNOO-Ppv7QfqHo9RKivv-1NUrezbuYN2krrNu4REuchtMA@mail.gmail.com> <Y5cXkyWUVf433sd5@kroah.com>
In-Reply-To: <Y5cXkyWUVf433sd5@kroah.com>
From:   Xingyuan Mo <hdthky0@gmail.com>
Date:   Mon, 12 Dec 2022 21:44:37 +0800
Message-ID: <CALV6CNOWteT=P4GDbe5ogHdui+z1_x3c4oP1=5ZfUeVFe0EuFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
To:     Greg KH <greg@kroah.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org, kolga@netapp.com, linux-nfs@vger.kernel.org,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 12, 2022 at 7:59 PM Greg KH <greg@kroah.com> wrote:
> Personally, I would prefer if this gets into Linus's tree first so that
> we can get it into a stable release before letting distros know about
> it

I already let them know about this issue on 8th Dec, and they asked me if I
could share this patch, which is why I asked here.

> otherwise you are forcing me into a very tight schedule that might
> require you to tell the world about the problem _BEFORE_ the fix is in
> Linus's or any stable kernel trees.

Sorry for any inconvenience caused to you.

Regards,
Xingyuan Mo
