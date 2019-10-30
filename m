Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A981EA4D4
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2019 21:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJ3Ued (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Oct 2019 16:34:33 -0400
Received: from fieldses.org ([173.255.197.46]:36958 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfJ3Ued (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 30 Oct 2019 16:34:33 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 129B51B90; Wed, 30 Oct 2019 16:34:33 -0400 (EDT)
Date:   Wed, 30 Oct 2019 16:34:33 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] SUNRPC: Trace gssproxy upcall results
Message-ID: <20191030203433.GB13537@fieldses.org>
References: <20191024133410.2148.3456.stgit@klimt.1015granger.net>
 <20191024153805.GA29859@fieldses.org>
 <CBBEAFFB-584C-4196-B24B-6664EABE5E39@oracle.com>
 <20191028164541.GC5339@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028164541.GC5339@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 28, 2019 at 12:45:41PM -0400, Bruce Fields wrote:
> On Thu, Oct 24, 2019 at 01:08:20PM -0400, Chuck Lever wrote:
> > 
> > 
> > > On Oct 24, 2019, at 11:38 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > 
> > > On Thu, Oct 24, 2019 at 09:34:10AM -0400, Chuck Lever wrote:
> > >> Record results of a GSS proxy ACCEPT_SEC_CONTEXT upcall and the
> > >> svc_authenticate() function to make field debugging of NFS server
> > >> Kerberos issues easier.
> > > 
> > > Inclined to apply.
> > > 
> > > The only thing that bugs me a bit is that this is just summarizing
> > > information that's passing between the kernel and userspace--so it seems
> > > like a job for strace or wireshark or something.
> > 
> > You could use those tools. However:
> > 
> > - strace probably isn't going to provide symbolic values for the GSS major status
> > 
> > - wireshark is unwieldy for initial debugging on servers with no graphics capability
> 
> I don't think tcpdump, copy the file, then run wireshark, is that bad,
> and there are probably ways to automate that if necessary.
> 
> The bigger problem seems to be that there's no way to do the capture:
> 
> 	https://unix.stackexchange.com/questions/219853/how-to-passively-capture-from-unix-domain-sockets-af-unix-socket-monitoring
> 
> I wish we could fix that somehow.

But, I don't know what to do about the AF_LOCAL tracing problem.  Oh
well.

Applying.

--b.
