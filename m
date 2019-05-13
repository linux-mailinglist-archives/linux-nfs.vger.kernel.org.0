Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814E71B1B6
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfEMIMo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 13 May 2019 04:12:44 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:53577 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMIMo (ORCPT
        <rfc822;groupwise-linux-nfs@vger.kernel.org:0:0>);
        Mon, 13 May 2019 04:12:44 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 13 May 2019 10:12:42 +0200
Received: from localhost (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 13 May 2019 09:12:26 +0100
Date:   Mon, 13 May 2019 10:12:24 +0200
From:   Jan Fajerski <jfajerski@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>, steved@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] manpage: explain why showmount doesn't really work
 against a v4-only server
Message-ID: <20190513081224.4giacxxvler3xvnt@jfsuselaptop>
References: <20190510215445.1823-1-jlayton@kernel.org>
 <20190511135442.GA15721@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190511135442.GA15721@fieldses.org>
User-Agent: NeoMutt/20180716
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, May 11, 2019 at 09:54:42AM -0400, J. Bruce Fields wrote:
>On Fri, May 10, 2019 at 05:54:45PM -0400, Jeff Layton wrote:
>> From: Jeff Layton <jlayton@redhat.com>
>>
>> I occasionally see people that expect valid info when running showmount
>> against a server that may export some or all filesystems via NFSv4.
>> Let's make it clear that it only works by talking to the remote MNT
>> service, and that that may not be available from a v4-only server.
Looks good...thanks Jeff!
>
>Looks fine.
>
>I wonder if it'd also be helpful for showmount to detect this case and
>say something.  E.g. the following (not even compileable, but you get
>the idea).
This would be ideal of course.
>
>We've also talked about trying to cobble together an export list by
>scanning the root filesystem over NFSv4, but that's likely to be
>complicated and wouldn't give all the same results without further
>protocol extensions anyway, so I think that idea's dead.
>
>--b.
>
>diff --git a/utils/showmount/showmount.c b/utils/showmount/showmount.c
>index 394f5284a219..de9a6d38783a 100644
>--- a/utils/showmount/showmount.c
>+++ b/utils/showmount/showmount.c
>@@ -115,6 +115,22 @@ static CLIENT *nfs_get_mount_client(const char *hostname, rpcvers_t vers)
> 	exit(1);
> }
>
>+void warn_if_v4_only(char *hostname)
>+{
>+	struct sockaddr_in server_addr, client_addr;
>+
>+	if (fill_ipv4_sockaddr(hostname, &serveraddr))
>+		return;
>+	server_addr.sin_port = htnos(NFS_PORT);
>+	client_addr.sin_family = 0;
>+	client_addr.sin_addr.s_addr = 0;
>+	clnt_ping(&server_addr, NFS_PROGRAM, 4, "tcp", &client_addr);
>+
>+	if (rpc.createerr == RPC_SUCCESS)
>+		printf("Server responding to NFSv4 but not MNT; try mounting "
>+			"%s:/ instead of showmount", hostname);
>+}
>+
> int main(int argc, char **argv)
> {
> 	char hostname_buf[MAXHOSTLEN];
>@@ -199,6 +215,7 @@ int main(int argc, char **argv)
> 		fprintf(stderr, "%s: unable to create RPC auth handle.\n",
> 				program_name);
> 		clnt_destroy(mclient);
>+		warn_if_v4_only(hostname);
> 		exit(1);
> 	}
> 	total_timeout.tv_sec = TOTAL_TIMEOUT;
>

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
