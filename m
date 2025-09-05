Return-Path: <linux-nfs+bounces-14078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A1B45D82
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70D7A463D2
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F75302164;
	Fri,  5 Sep 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="W0tmfawz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8E2FB0A1;
	Fri,  5 Sep 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088638; cv=none; b=XKdAI2nUVRj0tfdkgSP5EMzbST+6hxPNHcc0DwolHJ63NlZBLOBPf/GcA6OjZMC7jn7Sq0s2HxlBWN7KLcf+WVMzzjd182SNBS2qYGeousftdWFOGquftN1B3PjYkCidTV9iunpyT54jfyMpdIL3Pw6+0Z/1nCyguLwoXOhkKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088638; c=relaxed/simple;
	bh=ur5JMIMfJCcNnsAEuLEJhGLcooBQ1GgahWDjs8G8Eg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg0jzbjp2PjPKIqZE4AiHRF3e7h3gCYJr+MIdxoAU+q0lPrpymNM2TJAZeKlDkeioWt8nF0fPHXzvU/CZRkzyx655Lc4NE1a2rCHbaNaAO+bxzadgEV+olz+1NsEQuNgoBHxKXhBYnXBuYbkFMVJCh0Bodwa3UA7Rs0kK+bskrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=W0tmfawz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336cee72f40so21002671fa.2;
        Fri, 05 Sep 2025 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757088634; x=1757693434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ5lKT8MWq9BlErADmClzSG7/N/nbcrdEgrcT5yeDiw=;
        b=W0tmfawzhZkxxM76SXPrPbddDIIC9hjwskE9qLGECrMpgcL8p99FL85p+zZOT23xWf
         wX4BbL5FO3PbFrxDEFRWqjGv48BP9NsF7xvU/ywzY/+M3P+zOu1qCgHF9xU39OemCHB5
         nOFdvOF0tCRNLyFuM8XttUOnaxRXw1s9k6NDKvCilH+Wa7hzlsJzf3CpX8bv5WuxQk7u
         3yXERSlSmKuDkL5WjmzokuwjLOi/vlebyRoiqk6X3Y79MoDhuNGdXM5xW61IOj3vo3bJ
         Xd2clQjusuh8MG4Cb+dGBzQZzwBi/fNaNhvcAmMxOWlbdgdqgyurVbXrxCyhVeRThjvj
         xIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088634; x=1757693434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ5lKT8MWq9BlErADmClzSG7/N/nbcrdEgrcT5yeDiw=;
        b=XowmXnpqSBBMg+7dToPndEgH8TcDKEMjRM4FvRxLbT7JPnNQcy/Jod17Rw+QjWONYa
         2uAnqm0oitvgxt9K/Z2R+FhUfEU4nvFvoi0uPJesHOEzRK8Fv4rPwZG/VcIGAXKkOGRt
         5IifT6v9fGXX4RaqMiJxbr/y9FzfTGyV+dNFk203rLs2wMEJ2PUnwSjDoUf2xHHN+L7N
         AOatiJ3JTpK1JEdp+QiKOpPRmj8BfWqrN7T7tmGtN9FhDOb1fY4xhT9mjSVujCLhKuVs
         SjcG9MOgCMCn26kg3QRYUiCH7RO7jtE+nMpUOmmMJ7TAFTsn7PBB5JvKcl1CFl7uyUcQ
         yhbw==
X-Forwarded-Encrypted: i=1; AJvYcCURLyq3Y0cS9zcPBP72I/D3c6tYnb16g/Bg+W4Z7mWpm6UobdKPy514ZfAgjXhLl/WvdY9qEV0bfts=@vger.kernel.org, AJvYcCXqLIwL8F4fe45inNm3nQl+kvGeDuEfLgyxlC2KBfWNFdi6IF69u5sJKkqN/FZZ1AEcBoRVZkJu@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtZ2t+1Ns3GqKnBXxhXqxetk//Zmz5ZgyEJY6pX16zKXbp52l
	j3kMRmRSJmWcQn3nzX0+MPDTJOK1lRHP7M+FL0USgyY7RwM0GYaykEKMIsnB6GP3Kn1KB38HX55
	6CzvgUy5xgYLIC0+l2UYlzwqI0NSjjV4=
X-Gm-Gg: ASbGnctzZ33sRL+uic4DP+thjx4Ht6oCykKvEZLrYuqKo4k8xcrK0tVGus7YzToCLZ/
	IHJmoG8Z660U9jOAeZS0zXkG/HxLGbFGN7dtQPnG/VoP5xcir0idfs/ASgQI02OgLoCiFLwzblO
	m3YXQbpk9o13d42M7VZg8Gi9tTAmzLMhTubyVRLn1rMiSVEKE8OkD7z42xCxCGvi4x82w1lT/Sk
	ML4mKaWYaH0bykHNWEy+PwghzJbmebG9NoImuq8bg==
X-Google-Smtp-Source: AGHT+IH4XATrInTUDVReB90YvO/+WxFS3HmfZqUUGXwXcEnfrW4wwIz+ykUEAEhK5InYJjqbQmozqhPkoS3eqY6kZqE=
X-Received: by 2002:a05:651c:1b12:b0:332:2235:911c with SMTP id
 38308e7fff4ca-336caf71358mr68599551fa.37.1757088634191; Fri, 05 Sep 2025
 09:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731180058.4669-1-okorniev@redhat.com> <20250731180058.4669-4-okorniev@redhat.com>
In-Reply-To: <20250731180058.4669-4-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 5 Sep 2025 12:10:21 -0400
X-Gm-Features: Ac12FXzBiQ30iKKbP0zzoq1oKAENaPAn2hm04QJoePVvv8Y4CUwCe8BkLoQZJ38
Message-ID: <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com, 
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de, horms@kernel.org, 
	kbusch@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear NvME maintainers,

Are there objections to this patch? What's the path forward to
including it in the nvme code.

Thank you.

On Thu, Jul 31, 2025 at 2:01=E2=80=AFPM Olga Kornievskaia <okorniev@redhat.=
com> wrote:
>
> Revert kvec msg iterator before trying to process a TLS alert
> when possible.
>
> In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> message buffer is set prior to sock_recvmsg(). Hannes suggested
> that upon detecting that TLS control message is received log a
> message and error out. Left comments in the code for the future
> improvements.
>
> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Hannes Reinecky <hare@susu.de>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 688033b88d38..98cee10de713 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -120,7 +120,6 @@ struct nvmet_tcp_cmd {
>         u32                             pdu_len;
>         u32                             pdu_recv;
>         int                             sg_idx;
> -       char                            recv_cbuf[CMSG_LEN(sizeof(char))]=
;
>         struct msghdr                   recv_msg;
>         struct bio_vec                  *iov;
>         u32                             flags;
> @@ -1161,6 +1160,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_=
queue *queue)
>         if (unlikely(len < 0))
>                 return len;
>         if (queue->tls_pskid) {
> +               iov_iter_revert(&msg.msg_iter, len);
>                 ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>                 if (ret < 0)
>                         return ret;
> @@ -1217,19 +1217,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvme=
t_tcp_cmd *cmd)
>  static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  {
>         struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
> -       int len, ret;
> +       int len;
>
>         while (msg_data_left(&cmd->recv_msg)) {
> +               /* to detect that we received a TlS alert, we assumed tha=
t
> +                * cmg->recv_msg's control buffer is not setup. kTLS will
> +                * return an error when no control buffer is set and
> +                * non-tls-data payload is received.
> +                */
>                 len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>                         cmd->recv_msg.msg_flags);
> +               if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
> +                       if (len =3D=3D 0 || len =3D=3D -EIO) {
> +                               pr_err("queue %d: unhandled control messa=
ge\n",
> +                                      queue->idx);
> +                               /* note that unconsumed TLS control messa=
ge such
> +                                * as TLS alert is still on the socket.
> +                                */
> +                               return -EAGAIN;
> +                       }
> +               }
>                 if (len <=3D 0)
>                         return len;
> -               if (queue->tls_pskid) {
> -                       ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> -                                       &cmd->recv_msg, cmd->recv_cbuf);
> -                       if (ret < 0)
> -                               return ret;
> -               }
>
>                 cmd->pdu_recv +=3D len;
>                 cmd->rbytes_done +=3D len;
> @@ -1267,6 +1276,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tc=
p_queue *queue)
>         if (unlikely(len < 0))
>                 return len;
>         if (queue->tls_pskid) {
> +               iov_iter_revert(&msg.msg_iter, len);
>                 ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>                 if (ret < 0)
>                         return ret;
> @@ -1453,10 +1463,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_qu=
eue *queue,
>         if (!c->r2t_pdu)
>                 goto out_free_data;
>
> -       if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> -               c->recv_msg.msg_control =3D c->recv_cbuf;
> -               c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
> -       }
>         c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
>
>         list_add_tail(&c->entry, &queue->free_list);
> @@ -1736,6 +1742,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_=
queue *queue)
>                 return len;
>         }
>
> +       iov_iter_revert(&msg.msg_iter, len);
>         ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>         if (ret < 0)
>                 return ret;
> --
> 2.47.1
>
>

