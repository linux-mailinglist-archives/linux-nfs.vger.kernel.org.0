Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1035E99F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbhDMXUT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 19:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348785AbhDMXUT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 19:20:19 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A548C061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 16:19:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 954586A45; Tue, 13 Apr 2021 19:19:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 954586A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618355998;
        bh=SjHKEJ8R8SENaEiGhfvyU5HPDGqwPkTw2yrC9yRjn2A=;
        h=Date:To:Cc:Subject:From:From;
        b=u6yUhtf38GaOnbfYSyW6A9Wr2DnrspWgUzOAG6q+g1FsnF0L32uuv0KDSh7hQTtTN
         AkvZ8aaAYpl3Y21am2o7zwFYLJMaWPbjuhlVC9oUEU5CVmBx8T2N7fcVpp9n5F6s15
         fkc0/zE360Nnexp5+xiw8n0QEB5nnjfUWmUlQ0k8=
Date:   Tue, 13 Apr 2021 19:19:58 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>
Subject: generic/430 COPY/delegation caching regression
Message-ID: <20210413231958.GB31058@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

generic/430 started failing in 4.12-rc3, as of 7c1d1dcc24b3 "nfsd: grant
read delegations to clients holding writes".

Looks like that reintroduced the problem fixed by 16abd2a0c124 "NFSv4.2:
fix client's attribute cache management for copy_file_range": the client
needs to invalidate its cache of the destination of a copy even when it
holds a delegation.

--b.
