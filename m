Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBF299068
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782929AbgJZPCt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 11:02:49 -0400
Received: from fieldses.org ([173.255.197.46]:34068 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782928AbgJZPCt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Oct 2020 11:02:49 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id ADC93ABC; Mon, 26 Oct 2020 11:02:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org ADC93ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603724567;
        bh=kgEEm/ISndXcvQl2fVGsLNIuh3pbwL+P5lMUCVT1Cgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuJUzxhIn130rJg/ps6uqZ0Eu2dBodAlSjkuBSu4Qpyci0Ic5GhWt1k1Qg7YkEbfA
         6B5dIDswfZPnbi7wgAUZE07Ne3bVcBJv34ajyrn7tqQAYDU3DNstqYOrfYaIZCwbl6
         fIhP6CPOwhcUXbMIs1kzw55osLz9uA5Eo88adMrE=
Date:   Mon, 26 Oct 2020 11:02:47 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20201026150247.GB2417@fieldses.org>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
 <20200909134727.GA3894@fieldses.org>
 <20201026134216.GK74269@var.inittab.org>
 <40FDCE82-5895-4184-BAB3-AC221326EB34@oracle.com>
 <20201026144358.GM74269@var.inittab.org>
 <8A4C335B-446F-4385-BA7C-643911FF9498@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A4C335B-446F-4385-BA7C-643911FF9498@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 26, 2020 at 10:46:05AM -0400, Chuck Lever wrote:
> 
> 
> > On Oct 26, 2020, at 10:43 AM, Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es> wrote:
> > 
> > On Mon, Oct 26, 2020 at 09:58:17AM -0400, Chuck Lever wrote:
> >>>> So all I notice from this one is the readdir EIO came from call_decode.
> >>>> I suspect that means it failed in the xdr decoding.  Looks like xdr
> >>>> decoding of the actual directory data (which is the complicated part) is
> >>>> done later, so this means it failed decoding the header or verifier,
> >>>> which is a little odd:
> >>>> 
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 call_decode result -5
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016281] nfs41_sequence_process: Error 1 free the slot 
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016288] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 return 0, status -5
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 release task
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       freeing buffer of size 4144 at 00000000a3649daf
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 release request 0000000079df89b2
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       wake_up_first(00000000c5ee49ee "xprt_backlog")
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       rpc_release_client(00000000b930c343)
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 freeing task
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016309] _nfs4_proc_readdir: returns -5
> >>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: readdir(departamentos/innovacion) returns -5
> >>> 
> >>> Hi, Bruce et al.
> >>> 
> >>> Is there anything we can do to help debugging/fixing this? It's still
> >>> biting our users with a +4.20.x kernel.
> >> 
> >> Alberto, can you share a snippet of a raw network capture that shows
> >> the READDIR Reply that fails to decode?
> > 
> > Hi, Chuck.
> > 
> > Thanks for your reply. We're using "sec=krb5p", which makes the network
> > capture useless :-(
> 
> You can plug keytabs into Wireshark to enable it to decrypt the traffic.

Just skimming that range of history, there's some changes to the
handling of gss sequence numbers, I wonder if there's a chance he could
be hitting that?  You had a workload that would lead to calls dropping
out of the sequence number window, didn't you, Chuck?  Is there a quick
way to check whether that's happening?

--b.
