Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1684FDA33
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354415AbiDLI26 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354883AbiDLH05 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 03:26:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2947386
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 00:06:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D66FA21605;
        Tue, 12 Apr 2022 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649747205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfNz5QDc+1XLU+OLgS0baKBMTZRcqFFWzjxYusf9agU=;
        b=G1AsKhhyCbfdFTTyMzam9bxP/jg1Vdl/4+cniknG3SThqF+xCEtuBPqjxn6x5SG6uVeql/
        J4ShzJUlV3Kk+z//PkaiakKjQg4hZQ5oWhaFSVQCzS8ZTfgezBKq0yMaFn9l+IFnHjmmZE
        Mx9rD8A1W2ouAO4kq6sMCiMXlQXPw9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649747205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfNz5QDc+1XLU+OLgS0baKBMTZRcqFFWzjxYusf9agU=;
        b=Kikyhu6JBe3oBLB5NX/etrW4Ov282TPMLLsmT9EdgNeJHsdYkzBD7dD9YySm6JQvU651y5
        hipuKdgRaDUND2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C66F213A99;
        Tue, 12 Apr 2022 07:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kF0iIQQlVWKKcAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 12 Apr 2022 07:06:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add an explanation of NFSv4 client identifiers
In-reply-to: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>
References: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>
Date:   Tue, 12 Apr 2022 17:06:37 +1000
Message-id: <164974719723.11576.583440068909686735@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 12 Apr 2022, Chuck Lever wrote:
> To enable NFSv4 to work correctly, NFSv4 client identifiers have
> to be globally unique and persistent over client reboots. We
> believe that in many cases, a good default identifier can be
> chosen and set when a client system is imaged.
>=20
> Because there are many different ways a system can be imaged,
> provide an explanation of how NFSv4 client identifiers and
> principals can be set by install scripts and imaging tools.
>=20
> Additional cases, such as NFSv4 clients running in containers, also
> need unique and persistent identifiers. The Linux NFS community
> sets forth this explanation to aid those who create and manage
> container environments.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .../filesystems/nfs/client-identifier.rst          |  212 ++++++++++++++++=
++++
>  Documentation/filesystems/nfs/index.rst            |    2=20
>  2 files changed, 214 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/client-identifier.rst
>=20
> diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Document=
ation/filesystems/nfs/client-identifier.rst
> new file mode 100644
> index 000000000000..5d056145833f
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/client-identifier.rst
> @@ -0,0 +1,212 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +NFSv4 client identifier
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document explains how the NFSv4 protocol identifies client
> +instances in order to maintain file open and lock state during
> +system restarts. A special identifier and principal are maintained
> +on each client. These can be set by administrators, scripts
> +provided by site administrators, or tools provided by Linux
> +distributors.
> +
> +There are risks if a client's NFSv4 identifier and its principal
> +are not chosen carefully.
> +
> +
> +Introduction
> +------------
> +
> +The NFSv4 protocol uses "lease-based file locking". Leases help
> +NFSv4 servers provide file lock guarantees and manage their
> +resources.
> +
> +Simply put, an NFSv4 server creates a lease for each NFSv4 client.
> +The server collects each client's file open and lock state under
> +the lease for that client.
> +
> +The client is responsible for periodically renewing its leases.
> +While a lease remains valid, the server holding that lease
> +guarantees the file locks the client has created remain in place.
> +
> +If a client stops renewing its lease (for example, if it crashes),
> +the NFSv4 protocol allows the server to remove the client's open
> +and lock state after a certain period of time. When a client
> +restarts, it indicates to servers that open and lock state
> +associated with its previous leases is no longer valid.

Add "and can be removed immediately" This makes is clear how the two
sentences in the para relate.

> +
> +In addition, each NFSv4 server manages a persistent list of client
> +leases. When the server restarts, it uses this list to distinguish
> +between requests from clients that held state before the server
> +restarted and from clients that did not. This enables file locks to
> +persist safely across server restarts.

I still think this is a bit misleading.  It distinguished between
clients, not between requests.  I would prefer:

  When the server restarts client will attempt to recover their state.
  The server uses this list to distinguish between clients with state
  that can still be recovered and clients which don't - possibly because
  their state expired before the server restart.
 =20

> +
> +NFSv4 client identifiers
> +------------------------
> +
> +Each NFSv4 client presents an identifier to NFSv4 servers so that
> +they can associate the client with its lease. Each client's
> +identifier consists of two elements:
> +
> +  - co_ownerid: An arbitrary but fixed string.
> +
> +  - boot verifier: A 64-bit incarnation verifier that enables a
> +    server to distinguish successive boot epochs of the same client.
> +
> +The NFSv4.0 specification refers to these two items as an
> +"nfs_client_id4". The NFSv4.1 specification refers to these two
> +items as a "client_owner4".
> +
> +NFSv4 servers tie this identifier to the principal and security
> +flavor that the client used when presenting it. Servers use this
> +principal to authorize subsequent lease modification operations
> +sent by the client. Effectively this principal is a third element of
> +the identifier.
> +
> +As part of the identity presented to servers, a good
> +"co_ownerid" string has several important properties:
> +
> +  - The "co_ownerid" string identifies the client during reboot
> +    recovery, therefore the string is persistent across client
> +    reboots.
> +  - The "co_ownerid" string helps servers distinguish the client
> +    from others, therefore the string is globally unique. Note
> +    that there is no central authority that assigns "co_ownerid"
> +    strings.
> +  - Because it often appears on the network in the clear, the
> +    "co_ownerid" string does not reveal private information about
> +    the client itself.
> +  - The content of the "co_ownerid" string is set and unchanging
> +    before the client attempts NFSv4 mounts after a restart.
> +  - The NFSv4 protocol does not place a limit on the size of the
> +    "co_ownerid" string, but most NFSv4 implementations do not
> +    tolerate excessively long "co_ownerid" strings.

RFC5661 declares:
   struct client_owner4 {
           verifier4       co_verifier;
           opaque          co_ownerid<NFS4_OPAQUE_LIMIT>;
   };
and
   const NFS4_OPAQUE_LIMIT         =3D 1024;

so I think there is a clear limit that must be honoured by both sides.

> +
> +Protecting NFSv4 lease state
> +----------------------------
> +
> +NFSv4 servers utilize the "client_owner4" as described above to
> +assign a unique lease to each client. Under this scheme, there are
> +circumstances where clients can interfere with each other. This is
> +referred to as "lease stealing".
> +
> +If distinct clients present the same "co_ownerid" string and use
> +the same principal (for example, AUTH_SYS and UID 0), a server is
> +unable to tell that the clients are not the same. Each distinct
> +client presents a different boot verifier, so it appears to the
> +server as if there is one client that is rebooting frequently.
> +Neither client can maintain open or lock state in this scenario.
> +
> +If distinct clients present the same "co_ownerid" string and use
> +distinct principals, the server is likely to allow the first client
> +to operate normally but reject subsequent clients with the same
> +"co_ownerid" string.
> +
> +If a client's "co_ownerid" string or principal are not stable,
> +state recovery after a server or client reboot is not guaranteed.
> +If a client unexpectedly restarts but presents a different
> +"co_ownerid" string or principal to the server, the server orphans
> +the client's previous open and lock state. This blocks access to
> +locked files until the server removes the orphaned state.
> +
> +If the server restarts and a client presents a changed "co_ownerid"
> +string or principal to the server, the server will not allow the
> +client to reclaim its open and lock state, and may give those locks
> +to other clients in the mean time. This is referred to as "lock
> +stealing".

This is not a possible scenario with Linux NFS client.  The client
assembles the string once from various sources, then uses it
consistently at least until unmount or reboot.  Is it worth mentioning?

> +
> +Lease stealing and lock stealing increase the potential for denial
> +of service and in rare cases even data corruption.
> +
> +Selecting an appropriate client identifier
> +------------------------------------------
> +
> +By default, the Linux NFSv4 client implementation constructs its
> +"co_ownerid" string starting with the words "Linux NFS" followed by
> +the client's UTS node name (the same node name, incidentally, that
> +is used as the "machine name" in an AUTH_SYS credential). In small
> +deployments, this construction is usually adequate. Often, however,
> +the node name by itself is not adequately unique, and can change
> +unexpectedly. Problematic situations include:
> +
> +  - NFS-root (diskless) clients, where the local DCHP server (or
> +    equivalent) does not provide a unique host name.
> +
> +  - "Containers" within a single Linux host.  If each container has
> +    a separate network namespace, but does not use the UTS namespace
> +    to provide a unique host name, then there can be multiple NFS
> +    client instances with the same host name.
> +
> +  - Clients across multiple administrative domains that access a
> +    common NFS server. If hostnames are not assigned centrally
> +    then uniqueness cannot be guaranteed unless a domain name is
> +    included in the hostname.
> +
> +Linux provides two mechanisms to add uniqueness to its "co_ownerid"
> +string:
> +
> +    nfs.nfs4_unique_id
> +      This module parameter can set an arbitrary uniquifier string
> +      via the kernel command line, or when the "nfs" module is
> +      loaded.
> +
> +    /sys/fs/nfs/client/net/identifier
> +      This virtual file, available since Linux 5.3, is local to the
> +      network namespace in which it is accessed and so can provide
> +      distinction between network namespaces (containers) when the
> +      hostname remains uniform.
> +
> +Note that this file is empty on name-space creation. If the
> +container system has access to some sort of per-container identity
> +then that uniquifier can be used. For example, a uniquifier might
> +be formed at boot using the container's internal identifier:
> +
> +    sha256sum /etc/machine-id | awk '{print $1}' \\
> +        > /sys/fs/nfs/client/net/identifier
> +
> +Security considerations
> +-----------------------
> +
> +The use of cryptographic security for lease management operations
> +is strongly encouraged.
> +
> +If NFS with Kerberos is not configured, a Linux NFSv4 client uses
> +AUTH_SYS and UID 0 as the principal part of its client identity.
> +This configuration is not only insecure, it increases the risk of
> +lease and lock stealing. However, it might be the only choice for
> +client configurations that have no local persistent storage.
> +"co_ownerid" string uniqueness and persistence is critical in this
> +case.
> +
> +When a Kerberos keytab is present on a Linux NFS client, the client
> +attempts to use one of the principals in that keytab when
> +identifying itself to servers. Alternately, a single-user client
> +with a Kerberos principal can use that principal in place of the
> +client's host principal.

I think this happens even when "-o sec=3Dkrb?" isn't requested.  Is that
correct?  Is it worth stating that here?  I guess the next paragraph
suggests it, but making more explicit could help.

> +
> +Using Kerberos for this purpose enables the client and server to
> +use the same lease for operations covered by all "sec=3D" settings.
> +Additionally, the Linux NFS client uses the RPCSEC_GSS security
> +flavor with Kerberos and the integrity QOS to prevent in-transit
> +modification of lease modification requests.
> +
> +Additional notes
> +----------------
> +The Linux NFSv4 client establishes a single lease on each NFSv4
> +server it accesses. NFSv4 mounts from a Linux NFSv4 client of a
> +particular server then share that lease.
> +
> +Once a client establishes open and lock state, the NFSv4 protocol
> +enables lease state to transition to other servers, following data
> +that has been migrated. This hides data migration completely from
> +running applications. The Linux NFSv4 client facilitates state
> +migration by presenting the same "client_owner4" to all servers it
> +encounters.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +See Also
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  - nfs(5)
> +  - kerberos(7)
> +  - RFC 7530 for the NFSv4.0 specification
> +  - RFC 8881 for the NFSv4.1 specification.
> diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesy=
stems/nfs/index.rst
> index 288d8ddb2bc6..8536134f31fd 100644
> --- a/Documentation/filesystems/nfs/index.rst
> +++ b/Documentation/filesystems/nfs/index.rst
> @@ -6,6 +6,8 @@ NFS
>  .. toctree::
>     :maxdepth: 1
> =20
> +   client-identifier
> +   exporting
>     pnfs
>     rpc-cache
>     rpc-server-gss
>=20
>=20
>=20


Generally good - just a few suggestions to consider.

Thanks,
NeilBrown
