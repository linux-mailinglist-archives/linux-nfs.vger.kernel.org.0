Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562282DDDE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE2NPm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 09:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE2NPm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 09:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB963179164;
        Wed, 29 May 2019 13:15:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-143.phx2.redhat.com [10.3.117.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA0611972C;
        Wed, 29 May 2019 13:15:35 +0000 (UTC)
Subject: Re: [PATCH] manpage: explain why showmount doesn't really work
 against a v4-only server
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, jfajerski@suse.com
References: <20190510215445.1823-1-jlayton@kernel.org>
 <20190511135442.GA15721@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fe3a9c31-a4cc-0a38-9a8f-1af53e7665d0@RedHat.com>
Date:   Wed, 29 May 2019 09:15:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511135442.GA15721@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 29 May 2019 13:15:42 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce,

On 5/11/19 9:54 AM, J. Bruce Fields wrote:
> On Fri, May 10, 2019 at 05:54:45PM -0400, Jeff Layton wrote:
>> From: Jeff Layton <jlayton@redhat.com>
>>
>> I occasionally see people that expect valid info when running showmount
>> against a server that may export some or all filesystems via NFSv4.
>> Let's make it clear that it only works by talking to the remote MNT
>> service, and that that may not be available from a v4-only server.
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
> --b.
I'm a bit confused... Does this patch go along with Jeff's manpage change?

steved.
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
> 
