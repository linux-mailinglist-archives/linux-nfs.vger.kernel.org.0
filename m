Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35ADF112FC7
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfLDQQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 11:16:12 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:43760 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfLDQQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 11:16:12 -0500
Received: by mail-ua1-f53.google.com with SMTP id o42so2980651uad.10
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mHREBSEK4G84NzDdvksMPr/PijmzUN6sGLpVppdpLWg=;
        b=HsdloHmuAFkWfRNKSeiwOjq/tyt2QCvV5RxwHkcEv1J8SrjHUeLzI18VQ+sm7A62I3
         TH6/uZwDotSJNSPlRDuJPpBZchqdUX91t1aNTBHFEyp6+hmRN8w8olS9tCeI0WCa1A7i
         EQV+taopuFFmQgynMFDClXvS5f/p8gh6CpHhIrhjSAd3A+A4QlDVNu/hjrO3ANkK75Vn
         7WIHiqeqZ9X0Yb6w3Vm64CDqukrmkBaB2qJjNPz7M/0FKwM+g5CmqnVek8hqkmUMqGvr
         2PJHlG9DleMm9T/K1mT0aSers7lq8fKkq4Z9OtaxNxMPg8IyD6jFmtftkJdLjxd3JP/B
         dEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mHREBSEK4G84NzDdvksMPr/PijmzUN6sGLpVppdpLWg=;
        b=K+Gnfx6tA77OVwRuFFcTV1LSMTc6811S+eBOeBRXvCRIGtO7pgYaulhfLXVaNvJ8j5
         YS5klNS4y5g77L26h9ddtg/3oHv1ZNYzHzV22alDUf6DFpkvZW7c24uWcycuvPNdtpWG
         QMWiN+P1ZeaFz3q6/uof2MBsdNAPdcSC4gZGUkT127st1ZYVGvyCWttu55h8MXNMwKAr
         EFfNW1oWX5er8WhL0w7jcTKkbV3ptSUCFoRBgdd4b08/krChLMr2QE6XUlGWW3P6haY+
         q2vuFrArmTDtWIFIeUTaQnwrlgLJ7x5nvs+ECkUctnPiXJ409eItf7YLFITpgaawyNM4
         WyAA==
X-Gm-Message-State: APjAAAX2NgfpvXLppqDW/4A0BTPoJcDzSa9yuJOCgRfKJPV0qab/W1oY
        fdrVv4Z3ujIe0Kyjp6D+b7BUu/jFIHVRL/2WOpeVrRR+
X-Google-Smtp-Source: APXvYqx1Gm1ZlMt7jGiASb8pxyJcdUDHU5VSaqoeGLfdhO9X/6QuKhfZ6T9OGFKY2MkO7AqjXwYIoYgO4pMgo7L2p1U=
X-Received: by 2002:ab0:5a70:: with SMTP id m45mr3131184uad.65.1575476170761;
 Wed, 04 Dec 2019 08:16:10 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Dec 2019 11:15:59 -0500
Message-ID: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
Subject: rdma compile error
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

I git cloned your origin/cel-testing, it's on the following commit.
commit 37e235c0128566e9d97741ad1e546b44f324f108
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Fri Nov 29 12:06:00 2019 -0500

    xprtrdma: Invoke rpcrdma_ep_create() in the connect worker

And I'm getting the following compile error.

  CC [M]  drivers/infiniband/core/cma_trace.o
In file included from drivers/infiniband/core/cma_trace.h:302:0,
                 from drivers/infiniband/core/cma_trace.c:16:
./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
such file or directory
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
                                           ^
Is this known?
