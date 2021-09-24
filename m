Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE24178F9
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhIXQlX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhIXQlW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 12:41:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC82C061613
        for <linux-nfs@vger.kernel.org>; Fri, 24 Sep 2021 09:39:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A0E587044; Fri, 24 Sep 2021 12:39:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A0E587044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632501588;
        bh=1Io4w4omTWmPoE6dVB3tp13bq9TBvzj3hfqDHBNuo54=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=hMcMaAhPaVmEHfOQxZsZ/boJQL9wNTJBethAoHB4mCeLbhBvOBl6aP5rAHUyepiR4
         zRx1l87jq0vo1tAarGeCpm6lJotWWvse5YBjwQRJK9U0QhcGJkIR+7r88q9/ZzhZ37
         44NMfYFXXR963Nk2Yp6HQTdRWEaWPo8hkxYVzlt0=
Date:   Fri, 24 Sep 2021 12:39:48 -0400
To:     Kazi Anwar <kazia@srf-ext.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: nfs4err_delay
Message-ID: <20210924163948.GB13115@fieldses.org>
References: <CAGw7ksJxiKkOf2F9FUDCa_mSAkoU6U=vCXFcupsu+izKuEE1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGw7ksJxiKkOf2F9FUDCa_mSAkoU6U=vCXFcupsu+izKuEE1WA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 22, 2021 at 03:56:23PM -0500, Kazi Anwar wrote:
> We are running nfs v 4.1 on centos 7.6.
> We are seeing an NFS issue where when files/dirs are deleted from a
> client they are occasionally stuck at unlinkat system call(according
> to strace its stuck for 100.5 secs every time). Can anyone explain
> this behavior?
> Running tcp dump shows nfs4err_delay status sent from the server to
> the stuck client.

Client and server are both centos 7.6?

Is the NFS4ERR_DELAY a reponse to a REMOVE?

Does /proc/locks show a delegation held on the file the client's trying
to remove?

--b.
