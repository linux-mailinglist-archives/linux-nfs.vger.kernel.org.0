Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D765CB6A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 02:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjADB2Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 20:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjADB2R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 20:28:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21A13E8F
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 17:28:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n12so21799488pjp.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 17:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rw8yCZ7Jv54XXKPF+/Du0Oe++y8XRl3PcaxBaWRZUH0=;
        b=WezwhdRZHFmP83WvOsMW2H7kJokWGHDkPYyJOw7o5DX5VBNh+m8+62IN7CWyWVVBME
         Sr7qhtlotONKhfMDZyevQu2XVbMnglGP6lsmE3TPBxtXpTzvVu/xk3Z5BpnTmMQYROnI
         vJrl0kJ25Zq1B6PY4gmq1AKtReFtZrlU/1wvYAMN5aoVAJeeH1/DSF5OqkIVFjBxUtRG
         PpU5RRF1Dkj2/RFhOAzulQ28GYGo+hxFPkQazNFu4NjVfkfU7qC4UXK+kTQyOEb15c49
         nWh8VtyHp2QYsXmF3pwHE6d4RPJLA6quHqU2iDcj7z6xDgAiQxGXIgxXnqPDQVdzhcp0
         EL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rw8yCZ7Jv54XXKPF+/Du0Oe++y8XRl3PcaxBaWRZUH0=;
        b=j1pqQAC6MmFuUqpUUNUizN67Ko9UmE6y/0caGg4Nsd9ISy7qME0XOBqwYX/33A5Dfv
         pGsvWd/kWYvq8viE4aFzqe6oIKwwosP5M1Q+uMyhPsXuSXSryt2j7isOnfVlh4Bf1IfP
         nH5yFGL7B7GCvgzVH10EB6xLmUKhhhOYbM2xSad/qoPjOaJgnENt2bk7uIu2aebpDzkd
         khQYhhELYgy51K9IYGnuQjoXssfzKxgDhpAwvh8NRPsdAkVo0l9Y6lTrDicpO7oJf3Hh
         JZgcEfAWY7iIdXw/vJvqxwS37JyLAwfWrDXkfJdbg9Jd6ZSCto5UkLipMtjt5QVsijxp
         y84Q==
X-Gm-Message-State: AFqh2koqPK92yApIskKbSX5K+GTQkfHRnyps+EBvG9zblp7K4J4FEyNZ
        g8q7EJ1D8uZD4U5Tl0YLJSiDtCmTrGMB/Rxm/xtPhYyzTg==
X-Google-Smtp-Source: AMrXdXtrShJoH4K575CeC+BV3eX31HoZULOsFr84v6VRs55AmqiNeID96U27qzyCvrupKDw1h8FMfUNVJVNb8rVagrI=
X-Received: by 2002:a17:902:ef8d:b0:192:7363:b004 with SMTP id
 iz13-20020a170902ef8d00b001927363b004mr1897376plb.112.1672795696151; Tue, 03
 Jan 2023 17:28:16 -0800 (PST)
MIME-Version: 1.0
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Tue, 3 Jan 2023 17:28:01 -0800
Message-ID: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
Subject: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine credential
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have recently implemented a NFSv4.1/4.2 client mount
on FreeBSD that uses AUTH_SYS for ExchangeID, CreateSession
(and the other state maintenance operations)
using SP4_NONE and then it defers an RPC that does:
   PutRootFH { Lookup, Lookup,... Lookup } GetFH
until a user process/thread attempts to use the mount.
Once an attempt succeeds, the file handle for the mount
point is filled in and the mount works normally.
This works for both a FreeBSD NFSv4 server and a Linux
5.15 one.

Why do this?

It allows a sec=krb5 mount to work without any
machine credential on the client. (Both installing
a keytab entry for a host/nfs-client.domain in the
client or doing the mount based on a user principal's
TGT are bothersome.) The first user with a valid TGT
that attempts to access the mount completes the mount's
setup.

I envision that this will be used along with RPC-with-TLS
(which can provide both on-the-wire encryption and
peer authentication).  The seems to be a reasonable
alternative to a machine credential and a requirement
for RPCSEC_GSS integrity or privacy.

Why am I posting here?

I am wondering if the Linux client implementors are
interested in doing the same thing?

I think it is possible to extend NFSv4.2 with a new
enum state_protect_how4 value (SP4_PEER_AUTH?) that
would allow the client to specify what operations must
use RPC-with-TLS including peer authentication and which
must be allowed for this case (similar to SP4_MECH_CRED).
However, if the server forces the client to use RPC-with-TLS
plus peer authentication, that may be sufficient and does
not require any protocol extensions.

Comments?

rick
