Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE20E1BC79E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgD1SPG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 14:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1SPG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 14:15:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA9C03C1AB
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 11:15:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gr25so17998942ejb.10
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=pxjdZpqcamLG72XCoSC0lwx2EPV6FSiZswEBQmaksJg=;
        b=GRmXrXfMu0aHrweJmDldoLQs1l6BsdP3epaYKYbDr1apHyfPDV6ewbDRofsJxJGPaf
         DwdG33LsZ+GANlxzOfJ0p+jpe9Eq/ut//28m/7YSipMSw4pd2oRoTLrh/6Bk0nSYM+U8
         9ESHNGeZdTs1W06PMgnB3DCxhIAeUkYryCqYIO1kyM3MCjWeccGJvMEI6gxCHA2YMTnx
         jEOwyR6Sb/0e9+3dd6FPLQkpX4o6wEQGCwR3NPA13zjogEAbApw7Q3DcKrfbNzNC75Hu
         yfT4HwPF+kmeN8CoVVZSogN9IK0ZzoZVaAdLWYW8mjo9FBBQAvsAJJAW7Z/uPsrcsgSl
         lPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pxjdZpqcamLG72XCoSC0lwx2EPV6FSiZswEBQmaksJg=;
        b=cTeaZRHUXnk49me0S3LXPUlyDWxUFOXZYhGEjUb486fDjYY/Sbe/pAQIOTo9/3wnFq
         zXv84/MirlCZvlV0Di7I0vSt6XH46N/dEbD24KK9eLpkan8OQB3+eeL5UgLh1HdmQfgx
         HnyP9mY2m9eWXvWeVGrEaKWMR2fDID0tW+p8VB+cYT5F2unLvnfJiH07s4E6xjM0gjno
         hJFjS9++vFxWv9usVl1+XCPrpzquqa2FMlvPE65zOk/aHGa/MKEfOwlwYtyj4SLMx5ls
         B4odbZZ7PrGe+JtpGtHot8GhVTWAywCjxVi4IGlbVqJtDlGZGvWrYXV8L5piOrb4p8Q5
         whSw==
X-Gm-Message-State: AGi0PuYfOrhCDDX4vpZeSzZCfYfuY2/O5vHGSGMIWan5xLSeX5Hxvt2Z
        ON1LetT/uGno0ykphqS/itYSlgMyLm3WvDGRfBbtlA==
X-Google-Smtp-Source: APiQypKu66xPXaZNpJPPIM6ht+q9B8VzMCcfqlUE3iQ28LHQ6gSQxXdE6JthfYTPA7dQVbFp+uREKENqfxmHLKsCu6A=
X-Received: by 2002:a17:906:54cd:: with SMTP id c13mr24914880ejp.307.1588097704563;
 Tue, 28 Apr 2020 11:15:04 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 Apr 2020 14:14:53 -0400
Message-ID: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
Subject: handling ERR_SERVERFAULT on RESTOREFH
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folk,

Looking for guidance on what folks think. A client is sending a LINK
operation to the server. This compound after the LINK has RESTOREFH
and GETATTR. Server returns SERVER_FAULT to on RESTOREFH. But LINK is
done successfully. Client still fails the system call with EIO. We
have a hardline and "ln" saying hardlink failed.

Should the client not fail the system call in this case? The fact that
we couldn't get up-to-date attributes don't seem like the reason to
fail the system call?

Thank you.
