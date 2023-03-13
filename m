Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569E6B7DD9
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCMQmY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCMQmV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 12:42:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB036689
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 09:42:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 84DB725AA; Mon, 13 Mar 2023 12:42:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 84DB725AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1678725738;
        bh=r6vKyODVsb7Fp4J8abOHxqREIxHX6YnBIR5uLzFAwTU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=wVc/e2lddfbuMDUbI3ry/JZYnzjz2ndORfvrFjbmisqXxKziyBltwtU6zEDb3yA6Z
         nzIjW6X1K8x1n+Wz7hz52nv6O3aNgvk8pID32hUplhsTHYia12wCJpcblvYjJlFJf3
         p5jBJBGi2L750TDx0Dufzy/wQZhdMXLD69esikIA=
Date:   Mon, 13 Mar 2023 12:42:18 -0400
To:     =?utf-8?B?5ZGo5ZGo5aaI?= <466013856@qq.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: testChar and testBlock failed in pynfs
Message-ID: <20230313164218.GA32502@fieldses.org>
References: <tencent_78C9ABA9459BDA9B3E5CDCB7D28A02F03F07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_78C9ABA9459BDA9B3E5CDCB7D28A02F03F07@qq.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 13, 2023 at 06:25:58PM +0800, 周周妈 wrote:
> I think mknod for char or block device file need root permission.
> So&nbsp;&nbsp;no_root_squash is needed in&nbsp;/etc/exports in server.
> Is it right? Why not put this information in README file?

Yeah, it should probably be better documented.

For what it's worth, the scripts I used for my testing are in
http://git.linux-nfs.org/?p=bfields/testd.git;a=tree.  I did separate
runs with and without root.

--b.
