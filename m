Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C703F6498CA
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 07:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiLLGAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 01:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLLGAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 01:00:35 -0500
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6581130
        for <linux-nfs@vger.kernel.org>; Sun, 11 Dec 2022 22:00:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.valinux.co.jp (Postfix) with ESMTP id 99786A8F56;
        Mon, 12 Dec 2022 15:00:31 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
        by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TeRna_4rSsN2; Mon, 12 Dec 2022 15:00:31 +0900 (JST)
Received: from brer (vagw.valinux.co.jp [210.128.90.14])
        by mail.valinux.co.jp (Postfix) with ESMTP id 72B6BA8F50;
        Mon, 12 Dec 2022 15:00:31 +0900 (JST)
From:   =?iso-2022-jp?B?TUlOT1VSQSBNYWtvdG8gLyAbJEJMJzE6GyhCIBskQj8/GyhC?= 
        <minoura@valinux.co.jp>
To:     =?iso-2022-jp?B?U0hJTUFNT1RPIEhJUk9TSEkoGyRCRWdLXCEhTTU7VhsoQik=?= 
        <h-shimamoto@nec.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
References: <20221209003032.3211581-1-h-shimamoto@nec.com>
        <17D036AA-5F8A-497B-9D66-879E9D201BDD@hammerspace.com>
        <TYAPR01MB4912E93E6B1CBB92AFD5335CFFE29@TYAPR01MB4912.jpnprd01.prod.outlook.com>
Date:   Mon, 12 Dec 2022 15:00:31 +0900
In-Reply-To: <TYAPR01MB4912E93E6B1CBB92AFD5335CFFE29@TYAPR01MB4912.jpnprd01.prod.outlook.com>
        ("SHIMAMOTO \=\?iso-2022-jp\?B\?SElST1NISSgbJEJFZ0tcISFNNTtWGyhCKSIncw\=\=\?\=
 message of "Mon, 12 Dec 2022
        03:33:24 +0000")
Message-ID: <kk5h6y1cgao.fsf@brer.local.valinux.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> One question, how about simultaneous upcalls AUTH_GSS and AUTH_UNIX?
> I'm not sure there is the such case, but an error could be taken for the successful case, no? 

This is the auth_gss module, and we always come here to
obtain a GSS security context.  In sec=sys case we might
come here with RPC_AUTH_GSS_KRB5I (see nfs4_alloc_client()
in nfs4client.c), though.  In such case gssd might return an
EACCESS error.

-- 
Minoura Makoto <minoura@valinux.co.jp>
