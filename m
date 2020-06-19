Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B7201DBF
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgFSWEf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Jun 2020 18:04:35 -0400
Received: from fieldses.org ([173.255.197.46]:36460 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbgFSWEf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Jun 2020 18:04:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C8DA09235; Fri, 19 Jun 2020 18:04:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C8DA09235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592604274;
        bh=Iodc/fu4Aml7Sp+etETP+OLfo8Z3MTFGzC5xkxVzaPo=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=uDZWAfh+UWW8gJlfx794vpVgBvrwVRMAmxSvX0T3PdvWwjbfR430828r4B7AfIwTQ
         G9M08xPR8hajLFFUH31qeclzsUG4hU3dhy5+YNbOv4nUVkhyDiYC3Rg0XMe5Oswtaw
         qpnF6VXyUrrQ+YsKdR4Xs4wh/7V7UsGrRmYSsUFM=
Date:   Fri, 19 Jun 2020 18:04:34 -0400
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: RPC Pipefs: Frequent parsing errors in client database
Message-ID: <20200619220434.GB1594@fieldses.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 19, 2020 at 09:24:27PM +0000, Kraus, Sebastian wrote:
> Hi all,
> since several weeks, I am seeing, on a regular basis, errors like the following in the system log of one of my NFSv4 file servers:
> 
> Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open nfsd4_cb/clnt3bb/info: No such file or directory
> Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt3bb/info

I'm not sure what exactly is happening.

Are the log messages the only problem you're seeing, or is there some
other problem?

--b.

> 
> Looks like premature closing of client connections.
> The security flavor of the NFS export is set to krb5p (integrity+privacy).
> 
> Anyone a hint how to efficiently track down the problem?
> 
> 
> Best and thanks
> Sebastian
> 
> 
> Sebastian Kraus
> Team IT am Institut für Chemie
> Gebäude C, Straße des 17. Juni 115, Raum C7
> 
> Technische Universität Berlin
> Fakultät II
> Institut für Chemie
> Sekretariat C3
> Straße des 17. Juni 135
> 10623 Berlin
