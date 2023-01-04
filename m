Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EC65CBCA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 03:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjADCMU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 3 Jan 2023 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjADCMT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 21:12:19 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B2164A1
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 18:12:18 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id o17so18775985qvn.4
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 18:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7f27rir2Bs7pM/4tmzxqsU4CcjtJOJulrHSkyrOVseo=;
        b=ozqPV0KDbG4npb2BI97k/otVQ4qKKBRjthp1DXG1v5Un02tosmkBjjmuT+0re3oWVs
         HKkFKqnJO/HrHf+jRsTsQp7XSfkgcSOjynKz9ybdV+Wxzec3VECFUWaEhZKDLQ9fjmT0
         vKXbKfywZBU8J+gzvT9974oTw4vJWUs5a4S2oP97/TegEaz9507GkNqESbmJq0uBtTTS
         wmjoDnjLvPv5ARtaKfIU5YZ2OFxO68yPWBsvuRkumiq7KAakv4Zrp95u9qZTeX/7dgeo
         EW5NoJH3Lt8PYLAlkfGcheVMIAVSvEi6rV0mmzBbw/kuyAnSIL7kawbviMxnZHj/5kUP
         AldQ==
X-Gm-Message-State: AFqh2kpD2As6vaJ8QcDu/C/tWxOQvg07m++olC82UaIZ6uVOigcyb4ZB
        R0Mhqd5Llm7okPddW9EbIgn7REZBCA==
X-Google-Smtp-Source: AMrXdXtU6mx2PrpEHXUGdq2TkQx5twhgkzcSIMTO0kZFlYk9p9ghy48UWHJA3QotdmsSuRbxG1eCFQ==
X-Received: by 2002:a0c:8067:0:b0:4c6:f5e2:f13a with SMTP id 94-20020a0c8067000000b004c6f5e2f13amr65218545qva.37.1672798337848;
        Tue, 03 Jan 2023 18:12:17 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id 19-20020a370413000000b006feea093006sm22860343qke.124.2023.01.03.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 18:12:17 -0800 (PST)
Message-ID: <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
From:   Trond Myklebust <trondmy@kernel.org>
To:     Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org
Date:   Tue, 03 Jan 2023 21:12:16 -0500
In-Reply-To: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-01-03 at 17:28 -0800, Rick Macklem wrote:
> I have recently implemented a NFSv4.1/4.2 client mount
> on FreeBSD that uses AUTH_SYS for ExchangeID, CreateSession
> (and the other state maintenance operations)
> using SP4_NONE and then it defers an RPC that does:
>    PutRootFH { Lookup, Lookup,... Lookup } GetFH
> until a user process/thread attempts to use the mount.
> Once an attempt succeeds, the file handle for the mount
> point is filled in and the mount works normally.
> This works for both a FreeBSD NFSv4 server and a Linux
> 5.15 one.
> 
> Why do this?
> 
> It allows a sec=krb5 mount to work without any
> machine credential on the client. (Both installing
> a keytab entry for a host/nfs-client.domain in the
> client or doing the mount based on a user principal's
> TGT are bothersome.) The first user with a valid TGT
> that attempts to access the mount completes the mount's
> setup.
> 
> I envision that this will be used along with RPC-with-TLS
> (which can provide both on-the-wire encryption and
> peer authentication).  The seems to be a reasonable
> alternative to a machine credential and a requirement
> for RPCSEC_GSS integrity or privacy.
> 
> Why am I posting here?
> 
> I am wondering if the Linux client implementors are
> interested in doing the same thing?
> 
> I think it is possible to extend NFSv4.2 with a new
> enum state_protect_how4 value (SP4_PEER_AUTH?) that
> would allow the client to specify what operations must
> use RPC-with-TLS including peer authentication and which
> must be allowed for this case (similar to SP4_MECH_CRED).
> However, if the server forces the client to use RPC-with-TLS
> plus peer authentication, that may be sufficient and does
> not require any protocol extensions.
> 
> Comments?
> 

Are there really that many use cases for this? If you are using krb5
authentication, then you pretty much have to support identity mapping.
Unless you are talking about a hobby setup, then that usually means
backing your Kerberos server with either LDAP or Active Directory to
serve up account mappings, and it usually means protecting those
databases with some form of strong authentication as well.

IOW: for most setups, I would expect the machine credential requirement
to be a non-negotiable part of the total AD/Krb5+LDAP security package
that is implemented in userspace. Am I wrong?

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


