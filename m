Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8A12FCAA
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 19:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgACSkd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 13:40:33 -0500
Received: from fieldses.org ([173.255.197.46]:50644 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbgACSkc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Jan 2020 13:40:32 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id A504E1CB4; Fri,  3 Jan 2020 13:40:32 -0500 (EST)
Date:   Fri, 3 Jan 2020 13:40:32 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: CPU lockup in or near new filecache code
Message-ID: <20200103184032.GA25602@fieldses.org>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
 <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
 <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
 <A7C348BD-2543-492A-B768-7E3666734A57@oracle.com>
 <aa7857e4a9ac535e78353db53448efb1b58a57f9.camel@hammerspace.com>
 <980CB8E4-0E7F-4F1D-B223-81176BE15A39@oracle.com>
 <20200103164711.GB24306@fieldses.org>
 <90784f104ddb8b423869b1933abd9a12b66c6204.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90784f104ddb8b423869b1933abd9a12b66c6204.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 03, 2020 at 06:01:47PM +0000, Trond Myklebust wrote:
> I've got more coming. We've been doing data integrity tests and have
> hit some issues around error reporting that need to be fixed in knfsd
> in order to avoid silent corruption of data.
> 
> I'll be sending a bulk patchset for 5.5 soon.

OK, thanks.--b.
