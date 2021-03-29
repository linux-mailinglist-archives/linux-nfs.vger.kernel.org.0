Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2554034D4D9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhC2QX2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhC2QXY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Mar 2021 12:23:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270EEC061574
        for <linux-nfs@vger.kernel.org>; Mon, 29 Mar 2021 09:23:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt15so20363494ejb.12
        for <linux-nfs@vger.kernel.org>; Mon, 29 Mar 2021 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2ZV2OZeWSb/DCgm6a3tOgjc27mNKTYRcdug9xyueXDg=;
        b=CNSJZDdOAwrtV/yYNyK3p1JSuoxxWzg4AKd7C8XIrrQwdGR5HHKLpHNOA32XiEASdy
         uYBpajxqTj2M9IOK26cuEDUOVtssdU+7UTcRIojlW46T21zA0dFS49d0+ZN+xYLHH/RJ
         NWSteizU1Ye8Po+vNubrpkXIO+HhtN2OdWQEJjgHjmfNNyu54gvNK+C19W4ts9HFrJw3
         KMomixZ6deuHF2Id0rDfdxBZQ+mOnzox5357K8wMXu0bg7iqdTzJN9KbjcqFhoXzLHeY
         UFe2dA+Dy9TBV72n0lV1tZMGECJ6E2BTZzjnWzT4pBeuyrK+jt/FL1JZp4E21bsTYk8p
         erHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2ZV2OZeWSb/DCgm6a3tOgjc27mNKTYRcdug9xyueXDg=;
        b=uZmrkCTO/gt0fd4GyZx0YEPaqTUgkOgwTigzWdUXahr4Nhlt9GWCcOfqzm/B91Spfz
         ATWBHPqqxE4BWr/YLSpRZf3OUxbVnNtWJg6TSB9OMRGsiZ8dg/VmyzIegG/ogU8MMinO
         oZj3rkNsir5gvQvwCfCRT/Ol30JS3gttA4ff6OsXa2w39JH776BoReskA2kMHuZSfJjz
         6awTGXKiRc1nJzgKlgHs7ZjOao7uIUpu4KrUQj+KI0uq6GW2TX4EBD5AN5dbl74/AkEb
         DqK0NP9eqwL6vXVSuy+BWxINszb9Nx2cuLLnzy4Df/b5jnhAKbHU+lLUmlHQlhqhNxr5
         EKNw==
X-Gm-Message-State: AOAM530k3C4+eWyGiY+vh8xSMGWgapANe10R6xhGI13HQD/V6fXQouqV
        GiW5GqP/EF1M8byTSkiCaosb7S6tZFTzH3lZBdz8hIXS
X-Google-Smtp-Source: ABdhPJwiFmUfxLAYwnKDem9af12WDpqCR3IbnpQz/n1usAG6XOJfDYmqsvZ3RN8CZ4eooEzJC79JtH2273DZhQmks9c=
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr29475980ejc.510.1617035002894;
 Mon, 29 Mar 2021 09:23:22 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 29 Mar 2021 12:23:11 -0400
Message-ID: <CAN-5tyGzJAusTZe7-93N_GDxLtdOsoC=et3exOCyus37Gz8N5w@mail.gmail.com>
Subject: how should nconnect work with failed connections
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

I'm looking for what kinds of errors and how should the client be able
to recover from them when it comes to using the nconnect feature.

My first question: what kind of failures seem reasonable? Say the
client has 3 connections to the server (nconnect=3). Is it possible
that one of those functions breaks? For instance, I simulate this with
blocking any requests on that connection and sending an RST back to
the client. Besides an RST, are there any other interesting errors
that should be considered (ICMP port unreachable perhaps. In this case
the client keeps trying to send the same packet it sent before. In
RST, client tries to send a SYN)?

If the client had sent a request on that particular connection but
didn't get a response and now the connection is being RSTed. Should
the client 'give up' and send the same request on a different
connection? For v3,v4 I can see that it's a problematic idea because
the reply cache is based on the port.

Current client behaviour is that: client does not retry. Am I correct
in assuming that it shouldn't be changed? I'm assuming that an
application that issued that operation will hang (as in a single TCP
connection case). Once that transport is occupied, the other
transports are still available to send requests over to the server
un-obstructed.

My next question: should there be any connection badness detection? As
this transport is not marked in anyway and can be selected by another
RPC (if the previous request was ctrl-C-ed, releasing the transport
into the transport pool).

Thank you.
