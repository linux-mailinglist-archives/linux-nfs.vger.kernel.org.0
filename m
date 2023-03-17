Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA766BF255
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 21:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCQUW3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCQUW2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 16:22:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CEB44B2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 13:22:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 35D60719F; Fri, 17 Mar 2023 16:22:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 35D60719F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1679084546;
        bh=cMwPdy1joZd9bsxb0ylWPF6ykqs5p6C/CHS5UaqkTqs=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=GmeVYgThebdOLz8daTf8qCkvBW41G8PpgZ6iMFOrsce3udt0oCI+3JNtx0unC68tZ
         8RHoZ41GdOaNH4s/8lB4G6nx6DRNHJ1eFZXeb2ljMylaHOf9X5mxSMSwOWdv1PhAKt
         cAbEa3AZRsbFLYxKbDk5xBSOPM9QqzXOUzlrzrDQ=
Date:   Fri, 17 Mar 2023 16:22:26 -0400
To:     =?utf-8?B?5ZGo5ZGo5aaI?= <466013856@qq.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Re: testChar and testBlock failed in pynfs
Message-ID: <20230317202226.GA25626@fieldses.org>
References: <tencent_5534F052C9A729501BB69B325CC737AB8A07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_5534F052C9A729501BB69B325CC737AB8A07@qq.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 17, 2023 at 04:45:19PM +0800, 周周妈 wrote:
> &gt;runs with and without root.
> 
> Do you mean in&nbsp;/etc/exports&nbsp;with and without&nbsp;no_root_squash?
> Or run as root or not root?

I used no_root_squash on the export, then ran pynfs once as root and
once as a non-root user; details in that git tree if you're interested.

--b.

> Subject:Re: testChar and testBlock failed in pynfs
> 
> 
> On Mon, Mar 13, 2023 at 06:25:58PM +0800, 周周妈 wrote:
> &gt; I think mknod for char or block device file need root permission.
> &gt; So&nbsp;&nbsp;no_root_squash is needed in&nbsp;/etc/exports in server.
> &gt; Is it right? Why not put this information in README file?
> 
> Yeah, it should probably be better documented.
> 
> For what it's worth, the scripts I used for my testing are in
> http://git.linux-nfs.org/?p=bfields/testd.git;a=tree.  I did separate
> runs with and without root.
> 
> --b.
