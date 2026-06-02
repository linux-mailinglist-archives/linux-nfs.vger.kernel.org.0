Return-Path: <linux-nfs+bounces-22204-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LcMNHS38HmofbwAAu9opvQ
	(envelope-from <linux-nfs+bounces-22204-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 17:52:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7F62FFC2
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 17:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZQSj2Oh5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22204-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22204-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 233013056372
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290873F0A99;
	Tue,  2 Jun 2026 15:47:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D36366046;
	Tue,  2 Jun 2026 15:47:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415265; cv=none; b=M7kfw1vyXIvXieQvIL8YUoxANm44vE/3ssjKSGwgrFcPsjmFpWT010vGjRcNOsFT4NCeReow7pEqAl0Ws15kIAVVnYxMsXZZkN2xDnFfVoiV0YPCH6qzVPM2uODNEq45zaq/s1C74/onzParP+WFWOUXiIrzeG+fYF3YvpOglVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415265; c=relaxed/simple;
	bh=hi12WezZwD1WzYU1hlhwt5AiplPaczFeXs61kDWRjHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ng/PT+/COvrFXeQJGmAnWBVC29YDt9JLfrkf7IWctA67vuPaVA3UfLm7OUnkdMtZ6+dQ/qWaia0qYl1tHhs7sqAmBCCdyVBZwaH48uy34dq+cpAPET0vr11FoubQKGN4+zWdIyrrUtPeWpsoLpajtzg/hWwGH6Nsz+8bkz6XGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQSj2Oh5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704951F00893;
	Tue,  2 Jun 2026 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415263;
	bh=wLutiSegTJHA+jOz/grm9866m5nuAjpYHl81oTHKovM=;
	h=From:To:Cc:Subject:Date;
	b=ZQSj2Oh5tKjNbhIIGe99RwvQlsqwNkefrPnoo5XygIkfKYK48wxoy33nXLklLeAIW
	 UjGofUmSx6GSxATbGem0cK3dmcUhmoQiO9Xr0ZloUgpEU3jFCGYnSBaQEQzI00cSGT
	 ZvNaAWTGVYuJgpkbcRF9b5AekMr4YLY2S2qBYx3cSvvDeokEg+coAq6jMhR3Cy8GPO
	 M1SgWZP8LE7d9+yaU03bXzQN26BV5EpcJjNrhzA4ahHZcACEVoh+bNSoEjoItF38Cy
	 vUlThpwtXAbsrzU6CvsEyFTjqSGFMR+reBNle3Kmir8Ko8eRh9mHYWYBKcJxqVwhal
	 yiGh3U04OiM3Q==
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [RFC] NFS: named client identities for mTLS mounts and a per-namespace .nfs keyring
Date: Tue,  2 Jun 2026 11:47:37 -0400
Message-ID: <20260602154740.49861-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22204-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hare@suse.de,m:dhowells@redhat.com,m:jarkko@kernel.org,m:sagi@grimberg.me,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0B7F62FFC2

Today, exactly one x.509 certificate and private key pair can be
used at a time for all NFS mounts. The location of that pair is
set in /etc/tlshd/config.

We currently have an awkward experimental mechanism for specifying
an alternative x.509 certificate and private key for an xprtsec=mtls
NFS mount, but it needs to be completed so it can be documented and
advertised for use.

I asked Claude to write a rough draft of a design document that
outlines what needs to be done to finish the work. I would like
input on the kernel-side mechanism in particular for the
per-network-namespace keyring and the way userspace reaches it.


Problem
=======

NFS mutual-TLS mounts (xprtsec=mtls) need the client to present an
x.509 certificate and prove possession of its private key. The
handshake runs in userspace in tlshd; the kernel hands tlshd the
credentials by keyring serial number over the handshake genetlink
upcall.

The only front end today is two undocumented integer mount options:

    mount -o xprtsec=mtls,cert_serial=723847,privkey_serial=723848 \
          server:/export /mnt

The administrator must load the cert and key into the keyring out of
band, discover the integer serials, and paste them onto the command
line. Serials are opaque, non-reproducible across boots, and easy to
transpose. There is also no isolation: nfs_tls_key_verify() does a
global key_lookup() on the serial, and the .nfs keyring created in
fs/nfs/inode.c is module-global and never referenced again -- any tlshd
that learns a serial can read the key.

This RFC proposes a named, per-mount client-identity interface backed
by a provisioning CLI, and fixes the keyring to isolate credentials per
network namespace. The kernel handshake ABI (integer serials over
genetlink) does not change.


The cross-subsystem ask: a per-netns .nfs keyring
=================================================

Network namespace is the correct isolation domain. tlshd is bound to a
network namespace, not a user namespace: it services sockets passed up
from the kernel over the per-netns handshake genetlink socket, and one
tlshd runs per network namespace that needs TLS-protected mounts.

  - Replace the dead module-global .nfs keyring with one keyring per
    network namespace, held in struct nfs_net (fs/nfs/netns.h) and
    allocated at nfs_net_init(). The keys subsystem otherwise
    namespaces on user_namespace, so this is a kernel-held object
    referenced from nfs_net (like today's global keyring, but one per
    netns). The DNS resolver's per-netns key scoping (net->key_domain,
    request_key_net()) is precedent that netns-scoped key handling is
    acceptable.

  - tlshd attaches at handshake time, not at launch. This matters: the
    keyring may be empty or freshly created when tlshd starts, so
    linking it by name at startup is the wrong model. Instead NFS sets
    ta_keyring to the netns .nfs keyring serial in
    xs_tls_handshake_sync(), the kernel sends it as
    HANDSHAKE_A_ACCEPT_KEYRING, and tlshd links that serial into its
    session keyring per handshake -- the path tlshd already implements.
    Linking grants tlshd possession of the keyring and, through it, of
    the possessor-scoped cert and privkey keys.

  - Credential keys are created possessor-readable only (no
    KEY_USR_READ). That is what makes isolation enforceable rather
    than advisory: a key provisioned in namespace A is absent from B's
    keyring and unreadable by B's tlshd even if its serial leaks.

Open question, and where I most want input: userspace -- the
provisioning CLI and mount.nfs -- needs to name the kernel-held netns
keyring in order to add and search keys. Candidates, modeled on
KEYCTL_GET_PERSISTENT (security/keys/persistent.c):

  (a) a new keyctl command that links the caller's netns .nfs keyring
      into a destination keyring and returns its serial;
  (b) an NFS-specific request_key key type the module instantiates to
      point at the netns keyring;
  (c) a per-netns serial exported via procfs or netlink.

The per-netns keyring decision itself I consider settled; the retrieval
primitive is the open one. There is also a user_namespace accounting
nuance: keys added by userspace are quota-charged against a key_user
keyed by user_namespace even though the keyring lives in nfs_net. I
would like the keyrings folks to confirm the quota and ownership
interaction is sane when the user_ns and net_ns boundaries do not
coincide.


Userspace front end
===================

With the keyring in place the front end is straightforward and follows
the nvme-cli / cifscreds pattern.

A new nfs-utils tool -- working name nfstlskey, fitting the nfsidmap /
nfsconf family -- manages x.509 client identities:

    nfstlskey add  <identity> --cert cert.pem --key key.pem
    nfstlskey list
    nfstlskey remove <identity>

The add subcommand reads the PEM cert and key, converts each to DER,
and creates two "user" keys on the netns .nfs keyring ("user" because
tlshd consumes raw DER via keyctl_read_alloc()), with possessor-only
read. Description convention:

    nfs:x509:<identity>:cert
    nfs:x509:<identity>:privkey

The mount command names the identity:

    mount -o xprtsec=mtls,tls_identity=<identity> server:/export /mnt

mount.nfs runs in the caller's namespace, searches the .nfs keyring for
the two descriptions, and passes the existing cert_serial= and
privkey_serial= options to the kernel. tls_identity= is purely a
userspace convenience that resolves a name to the serials the kernel
already accepts; the raw serial options remain as a documented escape
hatch. Both get documented in nfs(5), with a new nfstlskey(8) page.

tlshd changes are minimal: confirm the per-handshake link of the passed
keyring happens before the cert and privkey serials are read, and
retire the now-unnecessary .nfs entry in the keyrings= startup path.


Future work: mTLS-protected NFSROOT
===================================

NFSROOT mounts run in the kernel at boot, in the initial network
namespace, before any userspace mount.nfs, nfstlskey, or possibly tlshd
exists. mTLS for NFSROOT therefore cannot rely on userspace
provisioning: the kernel must obtain the client cert and key itself --
the leading candidate is extracting key material from a TPM -- and
place it on the initial-netns .nfs keyring before the handshake, with a
tlshd available early (initramfs). The kernel-owned per-netns keyring
chosen here is a prerequisite: a userspace-created keyring could not be
populated at NFSROOT time. Out of scope for the initial work, but the
design must not foreclose it, and the same TPM-resident-key path would
inform an eventual PKCS#11/TPM identity-naming scheme.


Alternatives considered
=======================

  - request-key upcall keyed by server name (the nfsidmap model): most
    NFS-native and needs no mount option, but makes selection automatic
    rather than per-mount explicit. Worth revisiting if per-server
    auto-selection is ever wanted.

  - File paths in the mount options (strongSwan / wpa_supplicant model):
    forces mount.nfs to read key files and load the keyring on every
    mount and offers no reusable provisioned identity.

  - Document the raw serials only: does nothing for namespacing.


Comments welcome, particularly on the keyring retrieval primitive and
whether network namespace is the binding you would expect.

--
Chuck Lever

