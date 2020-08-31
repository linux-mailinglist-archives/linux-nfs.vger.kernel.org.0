Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED81C25817A
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgHaTCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgHaTCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 15:02:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B7C061573
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 12:02:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0F29B6EF3; Mon, 31 Aug 2020 15:02:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0F29B6EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598900538;
        bh=go4N8mKdk6CmOcPxa078FOFlfccqwAmE1TftCpACins=;
        h=Date:From:To:Cc:Subject:From;
        b=iYrVzPC4676yNgYXLnikHLIojYs5h/2Iqlwv+OM2E+xO93Cd80fXzGn4faZ0Gh1Tb
         QEMPRQb3pNLvM9Lpf2tF+McVWslh5ahk7SnDqYwv1zdhXEnB4OQTTDR9SPVGl7MTJJ
         w/WtW5PvsocCPbXGVKrLuY9OFfgckTxIueKvRCxQ=
Date:   Mon, 31 Aug 2020 15:02:18 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [bfields@home.fieldses.org: all 6970bc51 SUNRPC/NFSD: Implement
 xdr_reserve_space_vec() results]
Message-ID: <20200831190218.GA19571@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm getting a few xfstests failures, are they known?  Apologies if
they've already been discussed.

--b.

generic/020	- output mismatch (see /root/xfstests-dev/results//generic/020.out.bad)
    --- tests/generic/020.out	2019-12-20 17:34:10.433343742 -0500
    +++ /root/xfstests-dev/results//generic/020.out.bad	2020-08-29 13:03:29.270527451 -0400
    @@ -40,7 +40,8 @@
     
     *** add lots of attributes
     *** check
    -   *** MAX_ATTRS attribute(s)
    +getfattr: /mnt/attribute_36648: Argument list too long
    +   *** -1 attribute(s)
     *** remove lots of attributes
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/020.out /root/xfstests-dev/results//generic/020.out.bad'  to see the entire diff)

generic/097	- output mismatch (see /root/xfstests-dev/results//generic/097.out.bad)
    --- tests/generic/097.out	2019-12-20 17:34:10.453343686 -0500
    +++ /root/xfstests-dev/results//generic/097.out.bad	2020-08-29 13:07:00.070382348 -0400
    @@ -5,18 +5,16 @@
     *** Test out the trusted namespace ***
     
     set EA <trusted:colour,marone>:
    +setfattr: TEST_DIR/foo: Operation not supported
     
     set EA <user:colour,beige>:
     
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/097.out /root/xfstests-dev/results//generic/097.out.bad'  to see the entire diff)
