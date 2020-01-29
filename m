Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFBD14CF57
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgA2RM0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 12:12:26 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39622 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgA2RM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 12:12:26 -0500
Received: by mail-wm1-f47.google.com with SMTP id c84so638080wme.4
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=z4Hf0h5UVwoXDI4y0oEx4N0lVsJZ7hmxceDmsnlKcMU=;
        b=Oh3TwXiXs7Z0hXNi2OxSlrPqeEBuL5DbALg3EdX5RQUD/n9to/Ylso1wJxUOwkz+OM
         AijOdVi2wApcXHEMM2RcpMBnQU++eBzTD4uLJHRC5UAW7HuE/CuCe2bneQpYGvik0trx
         FGfZ3WvXbmWJh3fOh0CUNPlnFoaJJTJ5su7Z8xcKBHIgEPSUgNPry4AtJRBguGq7DDfj
         pryaGXCTU7XT+GxyXTfgVGA5ylWM5/rm5Mqxxsi8tZ5qWw8Aw+wqXbK42OfDaGOMM4KR
         WLr2tojSVVXOIJsTkJ0W7P5oqxJ0KJtl7DgLPMgXtQDDhMbYFGrhN3+XacoImI0ImR1O
         AVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z4Hf0h5UVwoXDI4y0oEx4N0lVsJZ7hmxceDmsnlKcMU=;
        b=YNbq9oQdgqj4uz1/gd9RRz3QeVvhWI3k4nC/nwtBbi+e8TdP44MeuZkRXDolQ4XB/E
         6CWeokjvsKt3VA0WlyltPAmzI3c9KLDk0hzLNolCW5gKSr2bMOcxaOWl0k9HN3u5WbkS
         niYLQZjXCjHKdOE8p51Uf7lKmy+QlIGd4uk71zwVoObo+FJXx2rNQPi7EIO5/Jgv0J2h
         OMqASFUCwLxA8+omtXZHFbNsC3gcAwNYmWn+xoEUL6gUy74wapIZ7CS/f8jhS8DnPQbp
         Qw9e0FIpbQygsjz3fgb7SEc2D0VBfSEprouHuur/wHu8+paojt63wHJ40uqUqJ8VeisV
         d3ew==
X-Gm-Message-State: APjAAAVHmH/b7RwqKL6cp+FkmAyhlo7LpXdR73PD+LfPZ1sOisy69VGt
        taRC9DKbaduS3walwlb5mFWbyImzlH9iMZMw71aUeA==
X-Google-Smtp-Source: APXvYqwS3wnqjtz7uPRdaZhaWHZgyTBmnXQLeKNq/fdnA+tyTDsXg7+KKXQOuFSfo3JW10hgDUezurNN75euqE4M5No=
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr213463wma.177.1580317943903;
 Wed, 29 Jan 2020 09:12:23 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 29 Jan 2020 12:12:12 -0500
Message-ID: <CAN-5tyGoKOQzPHjTikO4ScPGe7eyob5pLOH7JM3MfgFG1W7eDQ@mail.gmail.com>
Subject: question about nconnect implementation
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Correct me if I'm wrong but I believe currently the client will never
bind new (nconnect) connections to an existing session until it gets
an error CONN_NOT_BOUND_TO_SESSION, is that correct?
nfs4_proc_bind_conn_to_session() that iterates over the transports is
only called nfs4state's nfs4_bind_conn_to_session when cl_stat's flag
of BIND_CONN_TO_SESSION is set and it's set on error handling of
CONN_NOT_BOUND.

Is the reason client not explicitly sending BIND_CONN_TO_SESSION
before sending other operations is because client (implements)
specifies "no state protection" for the client? And according to the
spec if no state protection is used then just sending a SEQUENCE on a
new connection is sufficient to create an association between that
connection and the session?

Thank you.
