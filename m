Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75881E2509
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2020 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEZPJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 May 2020 11:09:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25435 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728166AbgEZPJZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 May 2020 11:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590505764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACFuke8pOSKawPsQjY8+5dwiFY1mnlewjlhuVCBGeEk=;
        b=Zt3OkVCtXZyOQZluKtQCE9F58MiKUfBsk7yoNyVASCHIfzHSUfH6lWnXaSqMfrHF0ruMj7
        eCJvoBJjJQfVDPJAxMcWer5u/3CE7Z/t16E72ERComlIADjDQdjeppAw6NqLNMsqhGwGP1
        Vy7eYjk40QZ2P+709A9cdbsQTjnaKpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-6bVtBAE3NoOMTVV2OuxAxw-1; Tue, 26 May 2020 11:09:21 -0400
X-MC-Unique: 6bVtBAE3NoOMTVV2OuxAxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C3D919057B6;
        Tue, 26 May 2020 15:09:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-189.phx2.redhat.com [10.3.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE8760E1C;
        Tue, 26 May 2020 15:09:19 +0000 (UTC)
Subject: Re: [PATCH v1] man: Update nfs(5) and rpc.gssd(8) discussion of
 keytab needs
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20200521182517.2331.18548.stgit@klimt.1015granger.net>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <87476210-c024-978a-eb8f-0a5f6ec96686@RedHat.com>
Date:   Tue, 26 May 2020 11:09:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200521182517.2331.18548.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/21/20 2:25 PM, Chuck Lever wrote:
> Because of the <anyname> wildcard feature in rpc.gssd, it's possible
> for a customer to deploy the same keytab on many of her NFSv4 clients
> to reduce the overhead of keytab distribution.
> 
> However, the practice of sharing the same service principal amongst
> NFSv4 clients brings with it some hazards. Add documentation of those
> exposures in our man pages.
> 
> The rpc.gssd(8) changes:
> - Remove some needless redundancy
> - Clarify the definition of "machine credentials"
> - Update the use of <anyname> to explicitly not recommend sharing
> service principals
> 
> The nfs(5) changes add two things:
> - A brief discussion of the primary security exposure of sharing
> service principals
> - A mention of the nfs4.nfs_unique_id module parameter
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Committed... (tag: nfs-utils-2-4-4-rc6)

steved.
> ---
>  utils/mount/nfs.man |   53 +++++++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index cc3a210ab81e..3ec286b43c4d 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -45,22 +45,20 @@ is known as a
>  .BR kerberos (1)
>  for more on principals).
>  .P
> -For certain operations, a credential is required
> -which represents no user,
> -is otherwise unprivileged,
> -and is always available.
> -This is referred to as a
> +Certain operations require a credential that
> +represents no particular user
> +or
> +represents the host itself.
> +This kind of credential is called a
>  .IR "machine credential" .
>  .P
> -Machine credentials are typically established using a
> -.IR "service principal" ,
> -whose encrypted password, called its
> -.IR key ,
> -is stored in a file, called a
> -.IR keytab ,
> -to avoid requiring a user prompt.
> -A machine credential effectively does not expire because the system
> -can renew it as needed without user intervention.
> +A host establishes its machine credential using a
> +.I "service principal"
> +whose encrypted password is stored in a local file known as a
> +.IR keytab .
> +A machine credential remains effective
> +without user intervention
> +as long as the host can renew it.
>  .P
>  Once obtained, credentials are typically stored in local temporary files
>  with well-known pathnames.
> @@ -93,30 +91,12 @@ See the description of the
>  .B -d
>  option for details.
>  .SS Machine Credentials
> -A user credential is established by a user and
> -is then shared with the kernel and
> -.BR rpc.gssd .
> -A machine credential is established by
> -.B rpc.gssd
> -for the kernel when there is no user.
> -Therefore
> -.B rpc.gssd
> -must already have the materials on hand to establish this credential
> -without requiring user intervention.
> -.P
> -.B rpc.gssd
> -searches the local system's keytab for a principal and key to use
> -to establish the machine credential.
> -By default,
> -.B rpc.gssd
> -assumes the file
> -.I /etc/krb5.keytab
> -contains principals and keys that can be used to obtain machine credentials.
> -.P
>  .B rpc.gssd
> -searches in the following order for a principal to use.
> -The first matching credential is used.
> -For the search, <hostname> and <REALM> are replaced with the local
> +searches the default keytab,
> +.IR /etc/krb5.keytab ,
> +in the following order for a principal and password to use
> +when establishing the machine credential.
> +For the search, rpc.gssd replaces <hostname> and <REALM> with the local
>  system's hostname and Kerberos realm.
>  .sp
>     <HOSTNAME>$@<REALM>
> @@ -133,15 +113,20 @@ system's hostname and Kerberos realm.
>  .br
>     host/<anyname>@<REALM>
>  .sp
> -The <anyname> entries match on the service name and realm, but ignore the hostname.
> -These can be used if a principal matching the local host's name is not found.
> +rpc.gssd selects one of the <anyname> entries if it does not find
> +a service principal matching the local hostname,
> +e.g. if DHCP assigns the local hostname dynamically.
> +The <anyname> facility enables the use of the same keytab on multiple systems.
> +However, using the same service principal to establish a machine credential
> +on multiple hosts can create unwanted security exposures
> +and is therefore not recommended.
>  .P
> -Note that the first principal in the search order is a user principal
> +Note that <HOSTNAME>$@<REALM> is a user principal
>  that enables Kerberized NFS when the local system is joined
>  to an Active Directory domain using Samba.
> -A password for this principal must be provided in the local system's keytab.
> +The keytab provides the password for this principal.
>  .P
> -You can specify another keytab by using the
> +You can specify a different keytab by using the
>  .B -k
>  option if
>  .I /etc/krb5.keytab
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 6f79c63a7e9c..19fe22fb5411 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -1639,52 +1639,55 @@ from a server's pseudo-fs
>  into one of the server's exported physical filesystems,
>  which often have more restrictive security settings than the pseudo-fs.
>  .SS "NFS version 4 Leases"
> -In NFS version 4, a lease is a period of time during which a server
> -irrevocably grants a file lock to a client.
> -If the lease expires, the server is allowed to revoke that lock.
> +In NFS version 4, a lease is a period during which a server
> +irrevocably grants a client file locks.
> +Once the lease expires, the server may revoke those locks.
>  Clients periodically renew their leases to prevent lock revocation.
>  .P
>  After an NFS version 4 server reboots, each client tells the
> -server about all file open and lock state under its lease
> +server about existing file open and lock state under its lease
>  before operation can continue.
> -If the client reboots, the server frees all open and lock state
> +If a client reboots, the server frees all open and lock state
>  associated with that client's lease.
>  .P
> -As part of establishing a lease, therefore,
> +When establishing a lease, therefore,
>  a client must identify itself to a server.
> -A fixed string is used to distinguish that client from
> -others, and a changeable verifier is used to indicate
> -when the client has rebooted.
> -.P
> -A client uses a particular security flavor and principal
> -when performing the operations to establish a lease.
> -If two clients happen to present the same identity string,
> -a server can use their principals to detect that they are
> -different clients, and prevent one client from interfering
> -with the other's lease.
> -.P
> -The Linux NFS client establishes one lease for each server.
> +Each client presents an arbitrary string
> +to distinguish itself from other clients.
> +The client administrator can
> +supplement the default identity string using the
> +.I nfs4.nfs4_unique_id
> +module parameter to avoid collisions
> +with other client identity strings.
> +.P
> +A client also uses a unique security flavor and principal
> +when it establishes its lease.
> +If two clients present the same identity string,
> +a server can use client principals to distinguish between them,
> +thus securely preventing one client from interfering with the other's lease.
> +.P
> +The Linux NFS client establishes one lease on each NFS version 4 server.
>  Lease management operations, such as lease renewal, are not
>  done on behalf of a particular file, lock, user, or mount
> -point, but on behalf of the whole client that owns that lease.
> -These operations must use the same security flavor and
> -principal that was used when the lease was established,
> -even across client reboots.
> +point, but on behalf of the client that owns that lease.
> +A client uses a consistent identity string, security flavor,
> +and principal across client reboots to ensure that the server
> +can promptly reap expired lease state.
>  .P
>  When Kerberos is configured on a Linux NFS client
>  (i.e., there is a
>  .I /etc/krb5.keytab
>  on that client), the client attempts to use a Kerberos
>  security flavor for its lease management operations.
> -This provides strong authentication of the client to
> -each server it contacts.
> +Kerberos provides secure authentication of each client.
>  By default, the client uses the
>  .I host/
>  or
>  .I nfs/
>  service principal in its
>  .I /etc/krb5.keytab
> -for this purpose.
> +for this purpose, as described in
> +.BR rpc.gssd (8).
>  .P
>  If the client has Kerberos configured, but the server
>  does not, or if the client does not have a keytab or
> 

