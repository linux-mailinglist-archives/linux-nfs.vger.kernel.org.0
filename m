Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C741B70B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 15:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfEMN3o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 09:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbfEMN3o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 May 2019 09:29:44 -0400
Received: from vulcan.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9368920862;
        Mon, 13 May 2019 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557754184;
        bh=ICEidDFEeOh+7WD03k4m+HCjz9xhqNetVTsHYsyGj04=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kZ4rUCUzn69dGPf0AxH9bBWVxuMmfFLYH8oel9eNZXBn8hQEee9kLfKk0VTPDfEQf
         Zt35gt7AIVw9KWem2grVGL/2dchADq8Z0vg4UvxtOh7vF1zG3yjYvWAfp2Op1MCUmW
         9i4FNP4ta5C6xWaifENyFx2e8o22gEU9K9To+6uc=
Message-ID: <593884facebf2ebcafcbe577845a961abbaa9928.camel@kernel.org>
Subject: Re: [PATCH] manpage: explain why showmount doesn't really work
 against a v4-only server
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     steved@redhat.com, linux-nfs@vger.kernel.org, jfajerski@suse.com
Date:   Mon, 13 May 2019 09:29:42 -0400
In-Reply-To: <20190511135442.GA15721@fieldses.org>
References: <20190510215445.1823-1-jlayton@kernel.org>
         <20190511135442.GA15721@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2019-05-11 at 09:54 -0400, J. Bruce Fields wrote:
> On Fri, May 10, 2019 at 05:54:45PM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > I occasionally see people that expect valid info when running showmount
> > against a server that may export some or all filesystems via NFSv4.
> > Let's make it clear that it only works by talking to the remote MNT
> > service, and that that may not be available from a v4-only server.
> 
> Looks fine.
> 
> I wonder if it'd also be helpful for showmount to detect this case and
> say something.  E.g. the following (not even compileable, but you get
> the idea).
> 
> We've also talked about trying to cobble together an export list by
> scanning the root filesystem over NFSv4, but that's likely to be
> complicated and wouldn't give all the same results without further
> protocol extensions anyway, so I think that idea's dead.
> 

Agreed.

> --b.
> 
> diff --git a/utils/showmount/showmount.c b/utils/showmount/showmount.c
> index 394f5284a219..de9a6d38783a 100644
> --- a/utils/showmount/showmount.c
> +++ b/utils/showmount/showmount.c
> @@ -115,6 +115,22 @@ static CLIENT *nfs_get_mount_client(const char *hostname, rpcvers_t vers)
>  	exit(1);
>  }
>  
> +void warn_if_v4_only(char *hostname)
> +{
> +	struct sockaddr_in server_addr, client_addr;
> +
> +	if (fill_ipv4_sockaddr(hostname, &serveraddr))
> +		return;
> +	server_addr.sin_port = htnos(NFS_PORT);
> +	client_addr.sin_family = 0;
> +	client_addr.sin_addr.s_addr = 0;
> +	clnt_ping(&server_addr, NFS_PROGRAM, 4, "tcp", &client_addr);
> +
> +	if (rpc.createerr == RPC_SUCCESS)
> +		printf("Server responding to NFSv4 but not MNT; try mounting "
> +			"%s:/ instead of showmount", hostname);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	char hostname_buf[MAXHOSTLEN];
> @@ -199,6 +215,7 @@ int main(int argc, char **argv)
>  		fprintf(stderr, "%s: unable to create RPC auth handle.\n",
>  				program_name);
>  		clnt_destroy(mclient);
> +		warn_if_v4_only(hostname);
>  		exit(1);
>  	}
>  	total_timeout.tv_sec = TOTAL_TIMEOUT;

Yeah, that certainly wouldn't hurt. I'd suggest we add that in a
separate patch though.

We will need to spell this out in the manpage either way. At least with
ganesha, you can export some filesystems via v3 and others via v4 only,
and the MNT service there will only report the v3 ones. In that case,
you have a reachable service, but the v4-only filesystems will be
missing from showmount's output.
-- 
Jeff Layton <jlayton@kernel.org>

