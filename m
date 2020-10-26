Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF0299010
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782263AbgJZOyK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 10:54:10 -0400
Received: from etc.inittab.org ([51.254.149.154]:45050 "EHLO etc.inittab.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782085AbgJZOyF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:05 -0400
Received: from var.inittab.org (249.171.116.91.static.reverse-mundo-r.com [91.116.171.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: smtp_auth_agi@correo-e.org)
        by etc.inittab.org (Postfix) with ESMTPSA id 2B0EBA10BA;
        Mon, 26 Oct 2020 15:54:04 +0100 (CET)
Received: by var.inittab.org (Postfix, from userid 1000)
        id 3E95B404E9; Mon, 26 Oct 2020 15:54:03 +0100 (CET)
Date:   Mon, 26 Oct 2020 15:54:03 +0100
From:   Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20201026145403.GN74269@var.inittab.org>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
 <20200909134727.GA3894@fieldses.org>
 <20201026134216.GK74269@var.inittab.org>
 <20201026141452.GA2417@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026141452.GA2417@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 26, 2020 at 10:14:52AM -0400, J. Bruce Fields wrote:
> Sorry, I just don't know what this is off the top of my head.  If I had
> the time, stuff I might try:
> 
> 	- look at the wire traffic with wireshark: try to figure out
> 	  which operation this is happening on, and if there's anything
> 	  unusual about the reply.  May be difficult if a lot of traffic
> 	  is required to reproduce.
> 	- if you're using krb5, try without just to see if that makes a
> 	  difference.
	
Using "sec=krb5p" here... And with lots of active clients. :-/

Oh! Could I add another entry in /etc/exports with krb5 without afecting
current krb5p clients?

> 	- look at history: gitk v4.19..v4.20.17 fs/nfs net/sunrpc, see
> 	  if anything looks relevant; or even just try a git bisect
> 	  (difficult again given the intermittent failure).
> 	- trace through the code to work out where call_decode might be
> 	  returning -EIO, try to narrow it down with tracepoints or even
> 	  just debugging printk's.

I'm afraid I don't have the skills to carry out those tasks, haven't
coded in C for decades, not to mention kernel/nfs hacking.
I guess we'll have to wait until someone else hits this too, or we
update the server and (hopefully/miraculously) fixes it self :-)

Thanks a lot,

Alberto

-- 
Alberto González Iniesta             | Universidad a Distancia
alberto.gonzalez@udima.es            | de Madrid
