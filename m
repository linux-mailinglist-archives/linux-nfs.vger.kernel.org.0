Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F954A4CAA
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380145AbiAaRB1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 12:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380092AbiAaRB0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 12:01:26 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88429C061714
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jan 2022 09:01:26 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1D28314DC; Mon, 31 Jan 2022 12:01:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1D28314DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643648485;
        bh=0SybmjnBwnrCwUiB2lYfHyeGbQk686HDypIrrNpHcdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Szv+/1SUsgCODzMM53eagQi3p1rizgzPAIRmtDoX18xXozkn4IlgSXuRnrgISjixz
         b3OA6WIXygKcw+hzIvbBJuycwRKuictWmI9InTCDHDlb1EIodnR5Zjlinj4lQNLV+h
         yiYoOM1KaO6+dGFdYdRQCFvOduOfu+roL8/CLBsQ=
Date:   Mon, 31 Jan 2022 12:01:25 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, goliath@sigma-star.at,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Subject: Re: [RFC PATCH] mountd: export: Deal with NFS filesystems
Message-ID: <20220131170125.GB30119@fieldses.org>
References: <20220131104316.10357-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220131104316.10357-1-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for continuing to look into this, it's interesting work.

On Mon, Jan 31, 2022 at 11:43:16AM +0100, Richard Weinberger wrote:
> When a NFS filesystem is exported usually NFSD refuses
> to export the filesystem because mountd was unable to provide
> an UUID and the kernel cannot derive a dev id from the NFS client
> super block.
> 
> To deal with this situation, teach uuid_by_path() how to generate
> an UUID from a NFS filesystem.
> 
> Using /proc/fs/nfsfs/volumes it is possible to find the NFS fsid
> from the backend and use it as seed for mountd's UUID mechanism.

Sorry, I haven't checked--what is that number, really?  It's probably
not the fsid returned from the server, as that wouldn't be guaranteed
unique across multiple servers.  But that means it's probably generated
in a way that doesn't guarantee it's stable across reboots.  And we need
filehandles to work across reboots.

I think we've got to generate fsid's ourself and keep an on-disk
database.

> This is the userspace side to make cross mounts work for NFS re-exports.
> The basic idea is that mountd takes the NFS fsid from the backend server
> and feeds into mountd'd existing UUID mechanism.
> 
> Getting the NFS fsid is currently a bit clumsy, mountd has to scan
> /proc/fs/nfsfs/volumes. With the upcoming fsinfo() system call this
> information could be transferred in a much simpler way.
> e.g. NFS client stores the fsid in its sb->s_uuid and fsinfo() exposes
> sb->s_uuid to userspace.
> 
> This approach works for v3-to-v4 and v4-to-v4 re-exports.
> v3-to-v3 does *not* work, the reason is that nfs_encode_fh() aborts due
> to not enough space in the fhandle.
> I'm still investigating on how to improve this case.

We might be able to do better, but I think a v4-only solution to start
would be OK.

> Currently I’m toying around with a NFS fsid to export FSID_NUM mappings
> scheme which are stored to disk.

I think something like that's more like what we need.

> Another possibility is a new fsid type for NFSD, where the raw NFS fsid
> from the backend server is mirrored. Although such a mirror mode makes
> local exports impossible.
> At the end of the day this is something the admin has to decide.
> I don't think there will be a generic solution which satisfies all needs.

We can provide options if we need to, but the costs of options can be
underestimated.  Ideally we'd at least have a default that's safe and
works for most cases.

--b.

> 
> Looking forward for your feedback. :-)
> 
> Thanks,
> //richard
> ---
>  support/export/cache.c | 65 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index a5823e92e9f2..053ad86619b8 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -331,6 +331,51 @@ static const unsigned long nonblkid_filesystems[] = {
>      0        /* last */
>  };
>  
> +static int get_uuid_from_fsid(char *path, char *uuid_str, size_t len)
> +{
> +	unsigned int min_dev, maj_dev, min_fsid, maj_fsid;
> +	int rc, n, found = 0, header_seen = 0;
> +	struct stat stb;
> +	FILE *nfsfs_fd;
> +	char line[128];
> +
> +	rc = nfsd_path_stat(path, &stb);
> +	if (rc) {
> +		xlog(L_WARNING, "Unable to stat %s", path);
> +		return 0;
> +	}
> +
> +	nfsfs_fd = fopen("/proc/fs/nfsfs/volumes", "r");
> +	if (nfsfs_fd == NULL) {
> +		xlog(L_WARNING, "Unable to open nfsfs volume file: %m");
> +		return 0;
> +	}
> +
> +	while (fgets(line, sizeof(line), nfsfs_fd) != NULL) {
> +		if (!header_seen) {
> +			header_seen = 1;
> +			continue;
> +		}
> +		n = sscanf(line, "v%*u %*x %*u %u:%u %x:%x %*s", &maj_dev,
> +			   &min_dev, &maj_fsid, &min_fsid);
> +
> +		if (n != 4) {
> +			xlog(L_WARNING, "Unable to parse nfsfs volume line: %d, %s", n, line);
> +			continue;
> +		}
> +
> +		if (makedev(maj_dev, min_dev) == stb.st_dev) {
> +			found = 1;
> +			snprintf(uuid_str, len, "%08x%08x", maj_fsid, min_fsid);
> +			break;
> +		}
> +	}
> +
> +	fclose(nfsfs_fd);
> +
> +	return found;
> +}
> +
>  static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
>  {
>  	/* get a uuid for the filesystem found at 'path'.
> @@ -362,7 +407,7 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
>  	 */
>  	struct statfs64 st;
>  	char fsid_val[17];
> -	const char *blkid_val = NULL;
> +	const char *fsuuid_val = NULL;
>  	const char *val;
>  	int rc;
>  
> @@ -375,7 +420,19 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
>  				break;
>  		}
>  		if (*bad == 0)
> -			blkid_val = get_uuid_blkdev(path);
> +			fsuuid_val = get_uuid_blkdev(path);
> +		else if (*bad == 0x6969 /* NFS_SUPER_MAGIC */) {
> +			char tmp[17];
> +			int ret = get_uuid_from_fsid(path, tmp, sizeof(tmp));
> +
> +			if (ret < 0) {
> +				xlog(L_WARNING, "Unable to read nfsfs volume file: %i", ret);
> +			} else if (ret == 0) {
> +				xlog(L_WARNING, "Unable to find nfsfs volume entry for %s", path);
> +			} else {
> +				fsuuid_val = tmp;
> +			}
> +		}
>  	}
>  
>  	if (rc == 0 &&
> @@ -385,8 +442,8 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
>  	else
>  		fsid_val[0] = 0;
>  
> -	if (blkid_val && (type--) == 0)
> -		val = blkid_val;
> +	if (fsuuid_val && (type--) == 0)
> +		val = fsuuid_val;
>  	else if (fsid_val[0] && (type--) == 0)
>  		val = fsid_val;
>  	else
> -- 
> 2.26.2
