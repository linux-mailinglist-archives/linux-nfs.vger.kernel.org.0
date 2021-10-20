Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B04434F60
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJTP4h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTP4g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 11:56:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67989C06161C
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 08:54:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1ED356CD2; Wed, 20 Oct 2021 11:54:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1ED356CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634745261;
        bh=xbbaLfjoA8xE5hiaOT8uMLUrYO+8KshP2SMZpcZczk8=;
        h=Date:To:Cc:Subject:From:From;
        b=EtFF/B+34JAnqz/9TFOJ48Dlgc4USlnhU0DDRzU2DzZVcPoG//jq7F9oJoj9T+JC3
         ezca6ZiRUFzK2ZPWDaAdCmhZ7JouMH+vdep7m66493PYifDNrPcrpN6iLdL10afF9w
         TgYFrSF43yMFZbYXeH/ILGsbGBtiS5uY1pfmXhvA=
Date:   Wed, 20 Oct 2021 11:54:21 -0400
To:     linux-nfs@vger.kernel.org
Cc:     dai.ngo@oracle.com,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: server-to-server copy by default
Message-ID: <20211020155421.GC597@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

knfsd has supported server-to-server copy for a couple years (since
5.5).  You have set a module parameter to enable it.  I'm getting asked
when we could turn that parameter on by default.

I've got a couple vague criteria: one just general maturity, the other a
security question:

1. General maturity: the only reports I recall seeing are from testers.
Is anyone using this?  Does it work for them?  Do they find a benefit?
Maybe we could turn it on by default in one distro (Fedora?) and promote
it a little and see what that turns up?

2. Security question: with server-to-server copy enabled, you can send
the server a COPY call with any random address, and the server will
mount that address, open a file, and read from it.  Is that safe?

Normally we only mount servers that were chosen by root.  Here we'll
mount any random server that some client told us to.  What's the worst
that random server can do?  Do we trust our xdr decoding?  Can it DOS us
by throwing the client's state recovery code into some loop with weird
error returns?  Etc.

Maybe it's fine.  I'm OK with some level of risk.  I just want to make
sure somebody's thought this through.

There's also interest in allowing unprivileged NFS mounts, but I don't
think we've turned that on yet, partly for similar reasons.  This is a
subset of that problem.

--b.
