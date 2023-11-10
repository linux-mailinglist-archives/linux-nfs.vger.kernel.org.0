Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B417E80E1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbjKJSTb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbjKJSRa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:17:30 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86A93D6
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 00:19:27 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ea82246069so929551fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699604367; x=1700209167; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3uaZA57uGarLIh4qs7s1mKoog9vNfRfAaoACzrHIoY8=;
        b=h56c9/bBJwtAO1CVNCg283HJOTYc6jJFimk5Mf5UDcuTIY1Bc2/mJHuNFydHB+kNWa
         Qc7JmwUrB/Te+zTk4v4xkC7BEqDKq0NfoibfZFCl4Btua8Dwjcngj5U+MZJzvktgT9CP
         WUA4BuSpWQs5qOjrylZ3AGr0Gbmn4V9B/DGVd+E8ga40bmYP9YKfRt/P2GzKyE8J7Z0G
         F3SIn0wTYvzdjcJiwkzO09zRNkyXQSLHpB0Zm/w/Oz1eptHNtrrT2xWYXqfincn/eQpb
         eR8KMSRJKFeQ7zs0pGfjl9zFFxOIqlvOJftUxa8AzvSORWm1l539fHLrKPJpA0AJSdXx
         1Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699604367; x=1700209167;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uaZA57uGarLIh4qs7s1mKoog9vNfRfAaoACzrHIoY8=;
        b=aKLcb574rlR16MffkzEIRR3e2eQwdUMI7UjlfnpB0SszHgv7qAgg9eYq4uKBWcMcJn
         P2QcImVPWQjNSX959aXaZd4LTFoDTwPasGDCzbUptlO1TGbhrV+4m3j1XtcNDftMwTPM
         uC6H5akdbp0fr4LqdViA8NT2lkJYdoiQ1XGHxMgomceuQzNbB1f2OxooY6HBn5ihIFmV
         wFA/Fk6Ie1vFeV/P1JQ6eZeY0iWJpt4NRl4Htgqr2HdMEljJV9aKGGl+jZpLDoRej9AN
         SvsX+nj1fFhKwKU5XyG6P539jEoi+E05urCLpR0X/iCaPg8LXuFV/c7a+DznipJTnJn9
         4Tww==
X-Gm-Message-State: AOJu0YyiR3HN0m2e7JZAnPvRhuykqetTEl09pYve/BRtCQIhCNjhQQNO
        OA0pTsdZomssEaXQHVB0NL34HtgdKvvHBPEuIzWwnVX0eI0=
X-Google-Smtp-Source: AGHT+IGOAETbWdzXhS1xpJVHyFt3L4ktb5Ry+YOquz1ZVoQh6uAzvF6AdKxDTpZWs6N7i59UGTGT9ogF+LhxoG3b3HQ=
X-Received: by 2002:a05:6870:c68b:b0:1e9:c28f:45b9 with SMTP id
 cv11-20020a056870c68b00b001e9c28f45b9mr8070955oab.19.1699604366848; Fri, 10
 Nov 2023 00:19:26 -0800 (PST)
MIME-Version: 1.0
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 09:18:00 +0100
Message-ID: <CANH4o6PDTLSVbMOm=oRLhuupRSkQ9bZ8NGBAmgAa5i6PNCm6Ag@mail.gmail.com>
Subject: BUG: nfsref(8) has no means to set a non-2049 port number for referrals
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

Hello,

simple bug report:
nfsref(8) has no means to set a non-2049 port number for referrals.

Expected behaviour:
nfsref(8) should be able to define a non-standard TCP port for
referrals, for example in case the NFSD port is going through a
firewall, or is tunneled via ssh or other means.

Actually behaviour.
No custom TCP port can be specified for referrals.

Thanks,
Martin
