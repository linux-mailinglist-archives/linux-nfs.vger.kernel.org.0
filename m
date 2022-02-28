Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157494C7867
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiB1S7L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 13:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbiB1S7J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 13:59:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21065522C8
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 10:58:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id r13so26786511ejd.5
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=WWANl2bU08BWGa90Y/qLd7VLJFwABkNgOot098o/gR0=;
        b=UngaGXGlpRAEOX282K6Oej/Wj0Z4mn5mesNLosXxAnPY30UDLwSGeYhnfQln4K1ijZ
         /Qfkbi8PdB63+SxoZYOXoBsGWWEyNvNXWix+UjkqBzdxuSOzDEQPp75tKnCgaCBAa0Ck
         oowK0OmROBkq0+3jWtHvmaAgF6+1fQz3vJ3+F5OMXTj1Ej88jSvY4+bOJqYcXfPt7WsP
         kXfYtmBQg9bS3eOFx9NoetNU9SO4lhTAlCTsphAAbHYrBF8wQ1N7jl3MM6k3hxowIkh/
         t1R4eXdWAJs7q4jcTI/OK+rNGgCesLnsy3KkqhSe28FZ2+EINxCSxQ7YEroX7OEwwuBs
         gMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WWANl2bU08BWGa90Y/qLd7VLJFwABkNgOot098o/gR0=;
        b=BFM/4EZAJdWbYsc94+0zCChAbqw6iogX3ROD4MBqk3lH06arD+YJO6hnpEs3mWMpav
         tglQs0yXVtfoy+1laZzABqV3sTBm1x1Fmbh6RBrEPeC7zaI8hkZnIbOHOUDBhERuAPyh
         IumyvWJGEhZYCceXLv3aIW6meLK2L0kK/YvEGPv5jD6yRpqTLiOxyZAmTc1C9RhhX0vk
         /ODO68H3N34C7KqMY8p6pDh1cvdzb8Ec1qMKSevJVPRqVC5qkYA2VOJtjqtD2iucNb0e
         kUt5nHWkwwxSG3HXQJZ0siL2HpsyS5DJqM4e87ILbD8qVNMdNgwBeMS7xwoK/UBxg5UD
         gokQ==
X-Gm-Message-State: AOAM531yVtUI8qbCKmdxKjYo//b0TLHLWaz6DkaXg8yL4U1mg7vkw0Az
        0VRfSiw22DFa9UD3TZB/LKpCRxF7NHy5qdoFVjzBNq6Z8vI=
X-Google-Smtp-Source: ABdhPJyMxwKjX6xbyA2T2mYR4LuXcOta4lLsPA5mxwk4xP0v98NfJ9+gtVkyynLTZEu+vMJ0FVWwo1KihzZ9tYr+mtI=
X-Received: by 2002:a17:907:b96:b0:6d0:ae6:d153 with SMTP id
 ey22-20020a1709070b9600b006d00ae6d153mr15758043ejc.699.1646074707216; Mon, 28
 Feb 2022 10:58:27 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 28 Feb 2022 13:58:16 -0500
Message-ID: <CAN-5tyE4n2WgQhtuX_1JZsHnyXXZgwGJbRYjw5jrA+bfVcC3uw@mail.gmail.com>
Subject: managing trunking
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello folks,

I would like to ask for what would be an acceptable solution to deal
with created trunking connections when there is a change in trunking
membership, specifically when a connection (ie., its endpoint) no
longer is part of the same group. An inaction on the client's part
would lead to unusable client.

Would a proposal to destroy trunking connections in as part of
DESTROY_SESSION be acceptable? The logic behind this solution is that
trunking membership was established as a part of a session, each
connection was tested to belong to trunkable server and added to that
session. Once the session is destroy and new created there is no
guarantee that the connections are to the same server that the new
session is created for. Trunking membership can be re-established at a
later time. I have some code that implements this solution but still
needs some testing.

Alternatively, if we keep connections past DESTROY_SESSION, then we
need a way to test that the same connections belong to the new session
that has been created, meaning that a probe for each connection on
create_session to see if they still belong to the same server as the
new session is created. Is that preferred over simply destroying
connections? I'm going to work on implementing this too and posting as
an alternative.

It has been expressed several times that the ultimate goal is to do
transport management in userspace so does it mean the solution to this
is also in userspace? Should there be upcalls to user land on
DESTROY_SESSION and CREATE_SESSION to destroy/create trunking
respectively but triggered via user land. But in this approach, while
this happens at user land speed,  will we be allowing the client to
get into a state where it's unusable (because its connections are
talking to servers that don't belong to the same trunking group)? Or
to prevent this, will we be allowing the userland to pause activities
in the kernel until the transports are squared away? I just don't see
how out-sourcing trunking membership changes to the user land is
better than handling it in the kernel when no operations can proceed
until trunking membership is corrected.

Any feedback on the approaches or its alternatives would be much appreciated.

Thank you for the feedback.

Thank you.
